require 'phimail.rb'

class PhiMailWrapper
	@phimail_user = "liveclinic@test.directproject.net"
	@phimail_pass = "b6ts1wg1"

	def initialize(user, pass) 
		@phimail_user = user
		@phimail_pass = pass
	end

	def send(recipient, data)
		PhiMailConnector.set_server_certificate(Rails.application.config.phimail[:pem]);
		c = PhiMailConnector.new Rails.application.config.phimail[:server], Rails.application.config.phimail[:port]

		c.authenticate_user @phimail_user, @phimail_pass

		puts "Send a CDA as an attachment";
		recip = c.add_recipient recipient

		puts "Recipient Info = #{recip}"

		c.set_subject data[:subject]
		c.add_text data[:message]

		# c.add_cda(IO.read(data.CDA)) if data.CDA

		c.add_raw(IO.read( data[:attach] ), File.basename(data[:attach])) unless data[:attach].blank?

		response_hash = []
		c.send.each do |sr|
			if sr.succeeded
				response_hash << {
					'result' => 'success',
					'recipient' => sr.recipient,
					'id' => sr.message_id
				}
			else
				response_hash << {
					'result' => 'failed',
					'recipient' => sr.recipient,
					'message' => sr.error_text
				}
			end
		end

		response_hash
	end

	def receive
		PhiMailConnector.set_server_certificate(Rails.application.config.phimail[:pem]);
		c = PhiMailConnector.new Rails.application.config.phimail[:server], Rails.application.config.phimail[:port]
		c.authenticate_user @phimail_user, @phimail_pass

		inbound_emails = []

		while true
			puts "============"
			puts "Checking mailbox"

			# check next message or status update
			cr = c.check

			if cr.nil? 
				puts "Check returned null; no messages on queue."
				break;
			elsif cr.is_mail?
				puts "A new message is available for #{cr.recipient}"
				puts "from #{cr.sender}; id #{cr.message_id}; " +
					"#att=#{cr.num_attachments}"

				temp = {
					'recipient': cr.recipient,
					'from': cr.sender,
					'id': cr.message_id,
					'att_num': cr.num_attachments,
					'files': [],
					'title': '',
					'content': '',
					'date': '',
					'mail_type': -1
				}

				(0 .. cr.num_attachments).each do |i|
					show_res = c.show i
					puts "MimeType = #{show_res.mime_type}; length=#{show_res.length}"

					if i.zero?
						show_res.headers.each do |header|
							puts "Header: #{header}"

							header_parts = header.split ': '
							if header_parts[0] == 'Date'
								temp[:date] = header_parts[1]
							elsif header_parts[0] == 'Subject'
								case header_parts[2][0, 5]
								when '::0::'
									temp[:mail_type] = 0
								when '::1::'
									temp[:mail_type] = 1
								when '::2::'
									temp[:mail_type] = 2
								end
								temp[:title] = header_parts[2..-1].join(': ')[5..-1]
							end
						end
					end

					if show_res.mime_type.start_with? 'text/'
						s = show_res.data
						puts "Content:\n#{s}"
						temp[:content] = s
					else 
						puts "Content: <BINARY>	Writing attachment file #{show_res.filename}"

						new_temp_dir = Rails.application.config.phimail[:attach_dir] + '/' + SecureRandom.hex(16)
						Dir.mkdir(new_temp_dir) unless File.exists?(new_temp_dir)
						output_filename = new_temp_dir + '/' + show_res.filename

						File.open(output_filename, "w") {|f| f.syswrite show_res.data }		

						temp[:files] << output_filename
					end

					if i.zero?
						(0 ... cr.num_attachments).each do |k|
							puts "Attachment #{k + 1}: #{show_res.attachment_info[k].mime_type}" +
							" fn: #{show_res.attachment_info[k].filename}" +
							" Desc: #{show_res.attachment_info[k].description}"
						end
					end
				end

				c.acknowledge_message

				inbound_emails << temp
			else 
				puts "Status message for ID = #{cr.message_id}"
				puts "	StatusCode = #{cr.status_code}"
				puts "	Info = #{cr.info}" if !cr.info.nil?
				if cr.status_code == "failed"
					# ...do something about a failed message...
					puts "Code block to handle a failed message is executing"
				end

				c.acknowledge_status
			end
		end

		inbound_emails
	end
end