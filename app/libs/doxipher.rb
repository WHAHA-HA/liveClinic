require 'openssl'
require "base64"
class Doxipher
  #:iv =>  #Pass in a 16 byte value. Defaults to 16 0 bytes which is not good. class Doxipher
	def initialize( key, options = {} )
		@base64 = options[:base64] || false
		@key = key.clone
		#@iv = options[:iv] || "\0" * 16
    @iv = 'x49e*wJVXr8BrALE'
	end
	def encrypt( plain = nil, &block )
		if @base64
			Base64.encode64( cipher( plain, false, &block ))
		else
			cipher( plain, false, &block )
		end
	end
	def decrypt( cipher_text = nil, &block ) 
		cipher(cipher_text, true, &block)
	end
	def <<( data)
		@data << @cipher.update( decode_if_needed(data) )
	end
	private
	def decode_if_needed(data)
		@base64 && @decrypt ? Base64.decode64(data) : data
	end
	def cipher( data = nil, _decrypt = false, &block ) 
		@decrypt = _decrypt
		@cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
		if _decrypt
			@cipher.decrypt
		else 
			@cipher.encrypt
		end
		@cipher.key = @key
		@cipher.iv = @iv
		if block_given? 
			@data = ''
			block.call self
		else
			@data = @cipher.update decode_if_needed(data) rescue nil
			@data = data if @data.nil?
		end
		@data << @cipher.final
		@data
	end
end