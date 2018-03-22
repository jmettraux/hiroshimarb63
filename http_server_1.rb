
require 'socket'

server = TCPServer.new(8080)

loop do

  client = server.accept

  lines = []
  while (l = client.readline("\r\n")) != "\r\n"
    lines << l.strip
  end

  client.puts lines.join("\n")
  client.close
end

