class RBravia
	@@configuration = {}

	def self.init(ip, psk, nick)
		@@configuration[ip] = ip
		@@configuration[psk] = psk
		@@configuration[nick] = nick
	end

	def self.register
		require 'rest-client'

		uri = "#{@@configuration[ip]}/sony/accessControl"
		psk = psk

		xml = "
		{
			'id':13,
			'method':'actRegister',
			'version':'1.0',
			'params':[{
				'clientid':'#{@@configuration[nick]}:1',
				'@@configuration[nick]':'#{@@configuration[nick]}'},
				[{
					'clientid':'#{@@configuration[nick]}:1',
					'value':'yes',
					'@@configuration[nick]':'#{@@configuration[nick]}',
					'function':'WOL'
				}]
			]}'"

		headers = {
			:Authorization => "Basic #{@@configuration[psk]}"
		}

		response = RestClient.post uri, xml, headers
		self.cookies = response.cookies
	end

	def self.wake
		puts "Wake up!"
	end

	def self.sendCommand(command)
		require 'rest-client'

		uri = "#{@@configuration[ip]}/sony/IRCC"

		xml = "
			<?xml version='1.0'?>
			<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/' s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'>
			  <s:Body>
			    <u:X_SendIRCC xmlns:u='urn:schemas-sony-com:service:IRCC:1'>
			      <IRCCCode>#{command}</IRCCCode>
			    </u:X_SendIRCC>
			  </s:Body>
			</s:Envelope>"

		response = RestClient.post uri, xml, {:content_type => xml, :SOAPAction => "urn:schemas-sony-com:service:IRCC:1#X_SendIRCC", :cookies => self.cookies}

		puts response
	end
end