require 'sfax.rb'
require 'phimail-wrapper.rb'

class ThirdPartyController < ApplicationController

  respond_to :json

  def index_fax_inbox
    profile = current_user.user_profile

    if profile.blank?
      render :json => { :success => 'fail', :error => 'No profile set' } 
    elsif profile.sfax_username.blank? || profile.sfax_apikey.blank? || profile.sfax_encryptionkey.blank? 
      render :json => { :success => 'fail', :error => 'SFax API Values are not set' }
    else
      receive_fax
      respond_with FaxInbox.where( :user_id => current_user.id ).order(created_at: :desc).all
    end
  end

  def read_fax_inbox
    params.require(:id)
    FaxInbox.update params[:id], { :is_read => true }
    render :json => { :success => 'ok' }
  end

  def delete_fax_inbox
    params.require(:id)

    fax = FaxInbox.find params[:id];
    # find ./tmp/uploads -type d -empty -delete : deleting all empty folder
    File.delete fax.file if fax.file.present? && File.exist?(fax.file)
    fax.destroy

    render :json => { :success => 'ok' }
  end

  def index_fax_sent
    respond_with FaxSent.where( :user_id => current_user.id ).order(created_at: :desc).all
  end

  def delete_fax_sent
    params.require(:id)

    fax = FaxSent.find params[:id];
    File.delete fax.file if fax.file.present? && File.exist?(fax.file)
    fax.destroy

    render :json => { :success => 'ok' }
  end

  def send_fax_sent
    params.require(:file)
    file = store_file('fax') 

    profile = current_user.user_profile

    if profile.blank?
      render :json => { :success => 'fail', :error => 'No profile set' } 
    elsif profile.sfax_username.blank? || profile.sfax_apikey.blank? || profile.sfax_encryptionkey.blank? 
      render :json => { :success => 'fail', :error => 'SFax API Values are not set' }
    else
      receive_fax
      respond_with FaxInbox.where( :user_id => current_user.id ).order(created_at: :desc).all
    end

    status = JSON.parse(send_fax(params[:fax], file.path))

    newFax = FaxSent.create!({
      :to => params[:fax],
      :user_id => current_user.id,
      :file => file.path,
      :notes => params[:notes],
      :status => (status['isSuccess']==true) ? 0 : 1,
      :queue_id => status['SendFaxQueueId'],
      :message => status['message']
    })

    render :json => { :success => 'ok', :data => newFax }
  end

  def resend_fax_sent
    params.require(:id)
    #oldFax = FaxSent.find params[:id]
    render :json => { :success => 'ok' }
  end

  # MAIL
  def index_mail_inbox
    params.require(:type)
    profile = current_user.user_profile

    if profile.blank?
      render :json => { :success => 'fail', :error => 'No profile set' }
    elsif profile.phimail_email.blank? || profile.phimail_password.blank?
      render :json => { :success => 'fail', :error => 'PhiMail API Values are not set' }
    else
      receive_message
      respond_with MailInbox.where({:user_id => current_user.id, :mail_type => params[:type]}).order(created_at: :desc).all
    end
  end

  def read_mail_inbox
    params.require(:id)
    MailInbox.update params[:id], { :is_read => true }
    render :json => { :success => 'ok' }
  end

  def delete_mail_inbox
    params.require(:id)

    mail = MailInbox.find params[:id];
    File.delete mail.file if mail.file.present? && File.exist?(mail.file)
    mail.destroy

    MailInbox.delete params[:id]
    render :json => { :success => 'ok' }
  end

  def index_mail_sent
    params.require(:type)
    respond_with MailSent.where({:user_id => current_user.id, :mail_type => params[:type]}).order(created_at: :desc).all
  end

  def delete_mail_sent
    params.require(:id)
 
    mail = MailSent.find params[:id]
    File.delete mail.file if mail.file.present? && File.exist?(mail.file)
    mail.destroy

    render :json => { :success => 'ok' }
  end

  def send_mail_sent
    params.require(:mail_type)

    profile = current_user.user_profile
    if profile.blank?
      render :json => { :success => 'fail', :error => 'No profile set' }
    elsif profile.phimail_email.blank? || profile.phimail_password.blank?
      render :json => { :success => 'fail', :error => 'PhiMail API Values are not set' }
    else
      file = store_file('mail') if params[:file]
      status = send_message(params[:to], '::' + params[:mail_type] + '::' + params[:title], params[:content], (file ? file.path : ''))

      newMail = MailSent.create!({
        :user_id  => current_user.id,
        :to       => params[:to],
        :title    => params[:title],
        :content  => params[:content],
        :file     => file ? file.path : '',
        :status   => 0,
        :mail_type => params[:mail_type],
      })
    end

    render :json => { :success => 'ok', :data => newMail }
  end

  def resend_mail_sent
    params.require(:id)
    #oldFax = FaxSent.find params[:id]
    render :json => { :success => 'ok' }
  end

  def download_fax
    params.require(:type)
    params.require(:id)

    fax = nil
    if params[:type] == 'inbox' 
      fax = FaxInbox.find params[:id]
    else
      fax = FaxSent.find params[:id]
    end

    send_file fax.file
  end

  def download_attachment
    params.require(:type)
    params.require(:id)

    mail = nil
    if params[:type] == 'inbox' 
      mail = MailInbox.find params[:id]
    else
      mail = MailSent.find params[:id]
    end

    send_file mail.file
  end

private
  
  def store_file(type = 'fax')
    uploader = nil
    if type == 'fax' 
      uploader = FaxUploader.new;
    elsif type == 'mail'
      uploader = MailAttachmentUploader.new
    end

    uploader.store! params[:file]

    uploader
  end

  def send_fax(number, filename)
    profile = current_user.user_profile

    sfax = SFaxWrapper.new profile.sfax_username, profile.sfax_apikey, profile.sfax_encryptionkey
    sfax.send_fax number, filename
  end

  def receive_fax
    profile = current_user.user_profile
    sfax = SFaxWrapper.new profile.sfax_username, profile.sfax_apikey, profile.sfax_encryptionkey

    loop do
      data = JSON.parse(sfax.receive_inbound_fax(25))

      if data['FaxCount'] > 0
        data['InboundFaxItems'].each do |faxItem|
          FaxInbox.create( {
            'user_id' => current_user.id,
            'from' => faxItem['FromFaxNumber'],
            'is_read' => 0,
            'file' => sfax.download_inbound_fax_as_pdf(faxItem['FaxId']),
            'fax_date_utc' => DateTime.parse(faxItem['FaxDateUtc']),
            'json' => data.to_s
            })
        end
      end

      break if data['HasMoreItems'].blank? || data['HasMoreItems'] =='false'
    end
  end

  def send_message(mail_address, title, content, attachment)
    profile = current_user.user_profile
    pw = PhiMailWrapper.new(profile.phimail_email, profile.phimail_password)

    pp pw.send( mail_address, {
      'subject': title,
      'message': content,
      'attach': attachment
    })
  end

  def receive_message
    #pw = PhiMailWrapper.new('liveclinic@test.directproject.net', 'b6ts1wg1')
    profile = current_user.user_profile
    pw = PhiMailWrapper.new(profile.phimail_email, profile.phimail_password)
    result_array = pw.receive

    result_array.each do |new_mail|
      MailInbox.create({
        'user_id'   => current_user.id,
        'from'      => new_mail[:from],
        'title'     => new_mail[:title],
        'content'   => new_mail[:content],
        'is_read'   => false,
        'file'      => new_mail[:att_num] > 0 ? new_mail[:files][0] : '',
        'mail_date_utc' => DateTime.strptime(new_mail[:date], '%m/%d/%y %I:%M %P'),
        'mail_type' => new_mail[:mail_type]
      })
    end
  end
end
