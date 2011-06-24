require 'open-uri'
require 'socket'
require 'timeout'
require 'benchmark'

@open_uri_result = {:successful => 0, :failed => 0}
@socket_result = {:successful => 0, :failed => 0}

def detect_https_via_open_uri(domain)
  url = "https://#{domain}"

  open(url) do |http|
    puts "open-uri OK"
    @open_uri_result[:successful] += 1
  end
rescue Exception => e
  puts "open-uri error: #{e}"
  @open_uri_result[:failed] += 1
end

def detect_https_via_tcp(domain)
  socket = TCPSocket.open(domain, 443)
  puts "socket OK"
  @socket_result[:successful] += 1
  socket.close
rescue Exception => e
  puts "socket error: #{e}"
  @socket_result[:failed] += 1
end

domains = []
domains << "www.google.com"
domains << "yottaa.onjira.com"
domains << "yottaa.notableapp.com"
domains << "www.alipay.com"
domains << "addons.mozilla.org"
domains << "www.yammer.com"
domains << "yottaa.unfuddle.com"
domains << "github.com"
domains << "www.paypal.com"
domains << "vip.icbc.com.cn"
domains << "pbsz.ebank.cmbchina.com"
domains << "rpm.newrelic.com"
domains << "bbs.et8.net"
domains << "foursquare.com"
domains << "rvm.beginrescueend.com"
domains << "peepcode.com"
domains << "reg.163.com"
domains << "getfirebug.com"
domains << "login.taobao.com"
# domains << ""

puts "open-uri"
result = Benchmark.measure do
  domains.each do |domain|
    puts "#{domain}"
    Timeout::timeout(10) {detect_https_via_open_uri(domain)}
    puts "------------------------------"
  end
end
puts result

puts "socket"
result = Benchmark.measure do
  domains.each do |domain|
    puts "#{domain}"
    Timeout::timeout(5) {detect_https_via_tcp(domain)}
    puts "------------------------------"
  end
end
puts result

puts "total: #{domains.size}"
puts "open-uri successful: #{@open_uri_result[:successful]}"
puts "open-uri failed: #{@open_uri_result[:failed]}"
puts "socket successful: #{@socket_result[:successful]}"
puts "socket failed: #{@socket_result[:failed]}"
