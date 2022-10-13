#
# *********************************************************
# * This is the BETA version of a sample Connector class, *
# * to guide development by those implementing in Ruby.   *
# *********************************************************
#
# PhiMailConnector class for phiMail Server
# 
# This sample class implements the phiMail Server Integration API calls to allow
# client software to send and receive messages and status information over
# an encrypted connection to the phiMail Server. (Ported from Java class)
# 
# EMR Direct Data Exchange Protocol API Version Implemented: v1.3.1
# 
# Version 1.0.104b
# 
# (c) 2013-2015 EMR Direct. All Rights Reserved.
# Use of this code is subject to the terms of the phiMail Developer
# License Agreement ("DLA"). This code may not be used, redistributed or 
# modified without the express written consent of EMR Direct, except as 
# permitted by the DLA.
# 
#

require 'openssl'
require 'socket'
#$KCODE = 'u'  # use UTF-8 encoding for strings

#
# @author EMR Direct
#
    
class SendResult 
  attr_reader :recipient  # string
  attr_reader :succeeded  # boolean
  attr_reader :message_id # string default = nil;
  attr_reader :error_text # string default = nil;
  
  def initialize(r, s, m) 
    @recipient = r
    @succeeded = s
    if s
      @message_id = m
    else
      @error_text = m
    end
  end
end

class CheckResult 
  attr_reader :mail         # boolean
  attr_reader :message_id   # string
  attr_reader :status_code  # string
  attr_reader :info         # string
  attr_reader :recipient    # string
  attr_reader :sender       # string
  attr_reader :num_attachments # int
  
  def initialize(m, id, sc, i, r, s, na)
    @mail = m
    @message_id = id
    @status_code = sc
    @info = i
    @recipient = r
    @sender = s
    @num_attachments = na
  end
  
  # for status messages
  def self.new_status(id, status, info)
    self.new false, id, status, info, nil, nil, 0
  end
  
  # for mail messages
  def self.new_mail(r, s, num_attach, id)
    self.new true, id, nil, nil, r, s, num_attach
  end
  
  def is_mail?
    @mail
  end
  
  def is_status? 
    !@mail
  end
end # class CheckResult

class ShowResult 
  attr_reader :part_num   # int
  attr_reader :headers    # Array of string
  attr_reader :filename   # string
  attr_reader :mime_type  # string
  attr_reader :length     # int
  attr_reader :data       # binary string of content
  attr_reader :attachment_info # array of AttachmentInfo
  
  def initialize(p, h, f, m, l, d, ai)
    @part_num = p;
    @headers = h;
    @filename = f;
    @mime_type = m;
    @length = l;
    @data = d;
    @attachment_info = ai;
  end
end # class ShowResult

class AttachmentInfo
  attr_reader :filename
  attr_reader :mime_type
  attr_reader :description
  
  def initialize(filename, mime_type, description)
    @filename = filename;
    @mime_type = mime_type;
    @description = description;
  end
end # Class AttachmentInfo

class PhiMailConnector
  
  @@VERSION = "1.0"
  @@BUILD = "104b"
  @@API_VERSION = "1.3.1"
  @@PHIMAIL_READ_TIMEOUT = 25000 # not used in this version of connector
  
  @@context = nil
  
  # Open a new connection to the phiMail server.
  # s is the hostname
  # p is the port
  def initialize(s, p = 32541)
    if @@context.nil?
      @@context = OpenSSL::SSL::SSLContext.new
      @@context.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    tcp_client = TCPSocket.new s, p
    @ssl_client = OpenSSL::SSL::SSLSocket.new tcp_client, @@context
    @ssl_client.connect
    send_command "INFO VER RUBY #{@@VERSION}.#{@@BUILD}"
  end
  
  # Set the trusted phiMail server SSL certificate.
  def self.set_server_certificate(filename)
    fail 'Set server certificate failed: invalid filename' if filename.nil?
    
    if @@context.nil?
      @@context = OpenSSL::SSL::SSLContext.new 
      @@context.ca_file = filename
      @@context.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
  end

  # Set the client certificate for authentication to the phiMail server.
  def self.set_client_certificate(filename, passphrase = nil)
    fail 'Set client certificate failed: invalid filename' if anchor_cert.nil?
    @@context = OpenSSL::SSL::SSLContext.new if @@context.nil?
    @@context.cert = filename
    @@context.key = OpenSSL::PKey.read filename, passphrase
    @@context.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end
  
  # Close the socket connection to the server.
  def close
    @ssl_client.close
  end
  
  # Internal method to send a command to the server.
  # Do not call this method directly.
  def send_command(command)
    if !command.encoding.ascii_compatible? || 
        (command.encoding.name != 'UTF-8' && !command.ascii_only?)
      send_command 'INFO ERR invalid character encoding.'
      return 'FAIL invalid character encoding.'
    end
    if command.include?("\n") || command.include?("\r")
      send_command 'INFO ERR illegal characters in command string.'
      return 'FAIL illegal characters in command string.'
    end
    @ssl_client.puts command
    @ssl_client.flush
    @ssl_client.gets.chomp
  end
  
  # Authenticate user.
  def authenticate_user(user, pass = nil)
    response = send_command("AUTH #{user}" + extra_param(pass))
    fail "Authenication failed: #{response}" if response != 'OK'
  end
  
  # Change password for the currently authenticated user.
  def change_password(pass)
    response = send_command "PASS #{pass}"
    fail "Password change failed: #{response}" if response != 'OK'
  end
  
  # Add a recipient to the current outgoing message.
  def add_recipient(recipient) 
    response = send_command "TO #{recipient}"
    fail "Add recipient failed: #{response}" if response != 'OK'
    @ssl_client.gets.chomp # returns recipient info
  end
  
  # Add a CC recipient to the current outgoing message.
  def add_cc_recipient(recipient) 
    response = send_command "CC #{recipient}"
    fail "Add CC recipient failed: #{response}" if response != 'OK'
    @ssl_client.gets.chomp # return recipient info
  end

  # Clear the current outgoing message.
  def clear
    response = send_command 'CLEAR'
    fail "Clear failed: #{response}" if response != 'OK'
  end
  
  # Logout currently authenticated user but keep connection open.
  def logout
    response = send_command 'LOGOUT'
    fail "Logout failed: #{response}" if response != 'OK'
  end
  
  # Terminate session with server. Should be followed by close.
  # Deprecated! Use close without calling bye first. 
  def bye
    response = send_command 'BYE'
    fail "Bye failed: #{response}" if response != 'BYE'
  end
  
  # Internal helper function to add content to the current outgoing message.
  # Do not call this method directly.
  def add_data(data, dataType, filename = nil, encoding = nil)
    if !encoding.nil? && (data.encoding.name != encoding || !data.valid_encoding?) && 
        (!data.encoding.ascii_compatible? || !data.ascii_only?)
      send_command 'INFO ERR invalid character encoding.'
      response = 'FAIL invalid character encoding.'
    else
      response = send_command("#{dataType} #{data.bytesize}" + extra_param(filename))
    end
    fail "Add #{dataType} failed: #{response}" if response != 'BEGIN'
    @ssl_client.write data
    @ssl_client.flush
    response = @ssl_client.gets.chomp
    fail ("Add #{dataType} failed:" + (response.nil? ? "" : response)) if response != 'OK'
  end
  
  # Add preformed MIME content to the current outgoing message.
  def add_mime(data)
    add_data data, 'ADD MIME', nil, 'US-ASCII'
  end
  
  # Add a CDA part to the current outgoing message.
  def add_cda(data, filename = nil)
    add_data data, 'ADD CDA', filename, 'UTF-8'
  end
  
  # Add an XML document to the current outgoing message.
  def add_xml(data, filename = nil)
    add_data data, 'ADD CDA', filename, 'UTF-8'
  end
  
  # Add a CCR part to the current outgoing message.
  # Deprecated! Use add_xml instead.
  def add_ccr(data, filename = nil)
    add_data data, 'ADD CCR', filename, 'UTF-8'
  end
  
  # Add a text part to the current outgoing message.
  def add_text(data, filename = nil)
    add_data data, 'ADD TEXT', filename, 'UTF-8'
  end
  
  # Add a binary (raw) data part to the current outgoing message.
  # data is treated as a binary string
  def add_raw(data, filename = nil)
    add_data data, 'ADD RAW', filename
  end
  
  # Set (or unset) Subject header on current outgoing message.
  def set_subject(data = nil)
    response = send_command("SUBJECT" + extra_param(data))
    fail "Set subject failed: #{response}" if response != 'OK'
  end
  
  # Set Final Delivery Notification request for the current outgoing message.
  # value is evaluated as a boolean
  def set_delivery_notification(value) 
    response = send_command('SET FINAL ' + (value ? '1' : '0'))
    fail "Set delivery notification failed: #{response}" if response != 'OK'
  end
  
  # Send the current outgoing message.
  # returns Array[SendResult]
  def send
    response = send_command 'SEND'
    fail "Send failed: #{response}" if response.start_with? 'FAIL'
    output = []
    while (!response.nil? && response != 'OK') 
      r_explode = response.strip.split(' ', 4)
      case r_explode[0]
      when 'ERROR'
        output.push(SendResult.new(r_explode[1], false, r_explode[2]))
      when 'QUEUED' 
        output.push(SendResult.new(r_explode[1], true, r_explode[2]))
      else #unrecognized
        fail "Send failed with unexpected response: #{response}"
      end # case
      response = send_command 'OK'
    end # while
    output
  end #send
  
  # Check message queue for new status notification or incoming mail message.
  # returns CheckResult or nil
  def check
    response = send_command 'CHECK'
    return nil if response == 'NONE'
    fail "Check failed: #{response}" if response.start_with? 'FAIL'
    if response.start_with? 'STATUS'
      r_explode = response.strip.split(' ', 4)
      return CheckResult.new_status(r_explode[1], r_explode[2],
        r_explode.length==4 ? r_explode[3] : nil)
    elsif response.start_with? 'MAIL'
      r_explode = response.strip.split(' ', 5)
      num_attach = Integer(r_explode[3])
      return CheckResult.new_mail(r_explode[1], r_explode[2], num_attach,
        r_explode[4])
    else 
      fail "Check failed with unexpected response:  #{response}"
    end
  end # check
  
  # Acknowledge current status notification to remove from queue.
  def acknowledge_status
    response = send_command 'OK'
    fail "Status acknowledgement failed: #{response}" if response != 'OK'
  end
  
  # Acknowledge current incoming mail message to remove from queue.
  def acknowledge_message
    response = send_command 'DONE'
    fail "Message acknowlegement failed: #{response}" if response != 'OK'
  end
  
  # Alias for acknowledgeMessage.
  def done
    acknowledge_message
  end
  
  # Retrieve a content part from the current incoming message.
  # message_part is an integer indicating the desired message part 0..n-1
  # returns ShowResult
  def show(message_part)
    response = send_command "SHOW #{message_part}"
    fail "Show #{messagePart} failed: #{response}" if response != 'OK'
    headers = nil
    filename = nil
    if message_part.zero?
      # get headers for part==0
      headers = []
      while ((response=@ssl_client.gets.chomp)!=nil && response.length()>0) 
        headers.push response
      end # while
    else
      # get filename for part > 0
      filename = @ssl_client.gets.chomp
    end # if
    
    mime_type = @ssl_client.gets.chomp
    length = Integer(@ssl_client.gets.chomp)
    buf = @ssl_client.read(length)
    fail "Show message content unexpected EOF" if buf.bytesize != length
    
    ai = nil; # Array of AttachmentInfo
    if message_part.zero? # get attachment data
      num_attach = Integer(@ssl_client.gets.chomp)
      ai = Array.new(num_attach) {
        a_filename = @ssl_client.gets.chomp
        a_mime_type = @ssl_client.gets.chomp
        a_description = @ssl_client.gets.chomp
        AttachmentInfo.new(a_filename, a_mime_type, a_description)
      }
    end # if    
    
    ShowResult.new(message_part, headers, filename, mime_type, length, buf, ai)
  end # show

  # Search the directory.
  # returns Array[String] containing JSON-encoded directory matches
  def search_directory(search_filter)
    response = send_command "LOOKUP JSON #{search_filter}"
    fail "Directory search failed: #{response}" if response != 'OK'
    
    num_results = Integer(@ssl_client.gets.chomp)
    search_results = Array.new(num_results) {
      @ssl_client.gets.chomp
    }
    search_results
  end # search_directory

  # Internal helper method.
  def extra_param(s)
    (!s.nil? && !s.length.zero?) ? " #{s}" : ''
  end
  
end # class PhiMailConnector
