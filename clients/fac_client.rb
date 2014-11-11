require 'ffi-rzmq'
require 'json'

context = ZMQ::Context.new

puts "Connecting to the Server..."
requester = context.socket(ZMQ::REQ)
requester.connect("tcp://localhost:5555")

loop do
  n = rand(20) + 1
  fac_request = { function: "fac", n: n }

  puts "Computing Factorial(#{n})"
  requester.send_string fac_request.to_json

  reply = ''
  requester.recv_string(reply)

  puts "Factorial(#{n}): #{reply}"
end
