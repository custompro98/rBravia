class RBravia
	def self.register
		require 'rest-client'

		uri = "192.168.10.156/sony/accessControl"

		xml = '{
			"id":13,
			"method":"actRegister",
			"version":"1.0",
			"params":[{
				"clientid":"rubyClient:1",
				"nickname":"rubyClient"},
				[{
					"clientid":"rubyClient:1",
					"value":"yes",
					"nickname":"rubyClient",
					"function":"WOL"
				}]
			]}'

		begin
			response = RestClient.post uri, xml
		rescue RestClient::ExceptionWithResponse => err
			puts err.response
		end

		# puts response
	end
	def self.sendCommand
		require 'rest-client'

		uri = "192.168.10.156/sony/IRCC"
		# uri = "www.google.com"

		command = "AAAAAQAAAAEAAAATAw=="
		xml = '
			<?xml version="1.0"?>
			<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
			  <s:Body>
			    <u:X_SendIRCC xmlns:u="urn:schemas-sony-com:service:IRCC:1">
			      <IRCCCode>#{command}</IRCCCode>
			    </u:X_SendIRCC>
			  </s:Body>
			</s:Envelope>'

		response = RestClient.post uri, xml, {:content_type => xml}, {:SOAPAction => "urn:schemas-sony-com:service:IRCC:1#X_SendIRCC"}
		# response = RestClient.get uri
		puts response
	end
end