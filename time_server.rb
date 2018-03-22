
require 'time'
require 'socket'

server = TCPServer.new(8080)
loop do
  client = server.accept
  client.puts
  client.puts Time.now.iso8601
  client.puts
  client.close
end

