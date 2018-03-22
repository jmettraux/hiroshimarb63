
require 'pp'
require 'socket'

server = TCPServer.new(8080)

loop do

  client = server.accept

  lines = []
  while (l = client.readline("\r\n")) != "\r\n"
    lines << l.strip
  end

  request = {}
    #
  method, path = lines[0].split(' ')
  request[:method] = method
  request[:path] = path
    #
  lines[1..-1].each { |l|
    key, value = l.split(':', 2)
    request[key.strip] = value.strip }

  PP.pp(request, client)
  client.close
end

