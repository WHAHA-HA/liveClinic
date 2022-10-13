	require 'doxipher.rb'
require 'faraday'
require 'pp'
require 'time'
require 'json'

class SFaxWrapper 

	@username = ""
	@apikey = ""
	@encryptionkey = ""

	def initialize(username, apikey, encryptionkey) 
		@username = username
		@apikey = apikey
		@encryptionkey = encryptionkey
	end

	def send_fax(fax_no, filename)
		tid = nil
		conn = Faraday.new(:url => Rails.application.config.sfax[:server], :ssl => { :ca_file => Rails.application.config.sfax[:pem] }	) do |faraday| #Certificate required
			faraday.request :multipart				# checks for files in the payload, otherwise leaves everything untouched
			faraday.request	:url_encoded			# form-encode POST params
			faraday.response :logger				# log requests to STDOUT
			faraday.adapter Faraday.default_adapter	# make requests with Net::HTTP
		end

		token = get_token()
		
		parts = ["sendfax?",	
				 "token=#{CGI.escape(token)}",	
				 "ApiKey=#{CGI.escape(@apikey)}",
				 "RecipientFax=#{fax_no}",	
				 "RecipientName=Gene", 
				 "OptionalParams=&"
		]
		
		path = "/api/" + parts.join("&").to_s

		response = conn.post path do |req|
			 req.body = {}
			 req.body['file'] = Faraday::UploadIO.new(filename, 'application/pdf', 'test2.pdf')
		end
		
		if ( response.status == 200 )
			return response.body
		else
			return nil
		end
	end

	#filename = 'C:/temp/test2.pdf'
	#fax_no = ""#Enter a valid 11 digit US Fax Number
	#send_fax(fax_no, filename)
	
	# body="{\"SendFaxQueueId\":\"9A4CEBC407C247419DCAAB1D3BE55D6A\",\"isSuccess\":true,\"message\":\"Fax is received and being processed\"}",


	def send_fax_status(faxid)
		#faxid = nil
		conn = Faraday.new(:url => Rails.application.config.sfax[:server], :ssl => { :ca_file => Rails.application.config.sfax[:pem] }	) do |faraday|
			faraday.request	:url_encoded			# form-encode POST params
			faraday.response :logger					# log requests to STDOUT
			faraday.adapter Faraday.default_adapter	# make requests with Net::HTTP
		end
		#pp conn
		token = get_token()
		parts = ["sendfaxstatus?",	
				 "token=#{CGI.escape(token)}",	
				 "ApiKey=#{CGI.escape(@apikey)}",
				 "SendFaxQueueId=#{faxid}"	#Third
		]
		path = "/api/" + parts.join("&").to_s
		response = conn.get path do |req|
			req.body = {}
		end

		pp response
		response
	end

	def receive_inbound_fax(maxitems)
		conn = Faraday.new(:url => Rails.application.config.sfax[:server], :ssl => { :ca_file => Rails.application.config.sfax[:pem] }	) do |faraday|
			faraday.request	:url_encoded			# form-encode POST params
			faraday.response :logger				# log requests to STDOUT
			faraday.adapter Faraday.default_adapter	# make requests with Net::HTTP
		end
		#pp conn
		token = get_token()

		parts = ["receiveinboundfax?",
				 "token=#{CGI.escape(token)}",
				 "ApiKey=#{CGI.escape(@apikey)}",
				 "StartDateUTC=#{}",
				 "EndDateUTC=#{}",
				 "MaxItems=#{maxitems}",
		]
		path = "/api/" + parts.join("&").to_s

		response = conn.get path do |req|
			req.body = {}
		end

		if ( response.status == 200 )
			return response.body
		else
			return nil
		end

		#pp response
	end


	def download_inbound_fax_as_pdf(faxid)
		conn = Faraday.new(:url => Rails.application.config.sfax[:server], :ssl => { :ca_file => Rails.application.config.sfax[:pem] }) do |faraday|
			faraday.request	:url_encoded			# form-encode POST params
			faraday.response :logger					# log requests to STDOUT
			faraday.adapter Faraday.default_adapter	# make requests with Net::HTTP
		end
		token = get_token()
		parts = ["downloadinboundfaxaspdf?",
				 "token=#{CGI.escape(token)}",
				 "ApiKey=#{CGI.escape(@apikey)}",
				 "FaxId=#{faxid}"
		]
		path = "/api/" + parts.join("&").to_s
		response = conn.get path
		a = response.body
		
		fname = Rails.root.join('tmp', 'uploads', 'fax', 'inbound', SecureRandom.hex( 16 ) + '.pdf').to_s

		File.open(fname, 'wb') do |f|
			f.write (a)
			f.close
		end
		
		fname
	end


	def download_inbound_fax_as_tif(faxid)
		conn = Faraday.new(:url => Rails.application.config.sfax[:server], :ssl => { :ca_file => Rails.application.config.sfax[:pem] }	) do |faraday|
		faraday.request	:url_encoded			# form-encode POST params
		faraday.response :logger					# log requests to STDOUT
		faraday.adapter	:net_http
		end
		token = get_token()
		parts = ["downloadinboundfaxastif?",
				 "token=#{CGI.escape(token)}",
				 "ApiKey=#{CGI.escape(@apikey)}",
				 "FaxId=#{faxid}"
		]
		path = "/api/" + parts.join("&").to_s
		response = conn.get path
		a = response.body
		File.open('C:/temp/2121206215127980253.tif', 'wb') do |f|
		#a.each do | byte |
		f.write (a)
		f.close
		end
		pp response
	end

	private 
	def get_token
		timestr = Time.now.utc.iso8601()
		raw = "Username=#{@username}&ApiKey=#{@apikey}&GenDT=#{timestr}"
		dox = Doxipher.new(@encryptionkey, {:base64=>true})
		cipher = dox.encrypt(raw)
		return cipher
	end
end