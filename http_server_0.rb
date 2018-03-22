# encoding: UTF-8

require 'socket'

server = TCPServer.new(8080)

loop do

  client = server.accept

  s = ''
  while ! s.match(/\r\n\r\n\z/)
    s += client.read(1)
  end
  puts s
  s += "やま"

  client.puts s
  client.close
end

