
require 'pp'
require 'uri'
require 'socket'


def to_h(query_string)
  query_string
    .split('&')
    .inject({}) { |h, e| k, v = e.split('=', 2); h[k] = v; h }
end

server = TCPServer.new(8080)


loop do

  client = server.accept

  lines = []
  while (l = client.readline("\r\n")) != "\r\n"
    lines << l.strip
  end

  request = {}
  method, path = lines[0].split(' ')
  request[:method] = method
  request[:path] = path
  lines[1..-1].each { |l| k, v = l.split(':', 2); request[k.strip] = v.strip }

  _, query = URI.unescape(request[:path]).split('?', 2)
  if query
    request[:query] = to_h(query)
  end

  if len = request['Content-Length']
    request[:content] = client.read(len.to_i)
  end
  if request['Content-Type'] == 'application/x-www-form-urlencoded'
    request[:form] = to_h(URI.unescape(request[:content]).split('?', 2).last)
  end

  PP.pp(request, client)
  client.close
end

