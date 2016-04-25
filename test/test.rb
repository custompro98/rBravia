require 'rBravia'

ip = "192.168.10.156"
psk = "1203"
nick = "rubyClient"
volDown = "AAAAAQAAAAEAAAATAw=="

RBravia.init(ip, psk, nick)
RBravia.register
RBravia.sendCommand(volDown)