require 'ffi-rzmq'
require 'json'

context = ZMQ::Context.new

puts "Connecting to the AckFibFac Server..."
requester = context.socket(ZMQ::REQ)
requester.connect("tcp://localhost:5555")

loop do
  m = rand(4)
  n = rand(4)
  ack_request = {fn: "ack", m: m, n: n}

  puts "Computing Ackermann(#{m}, #{n})"
  requester.send_string ack_request.to_json

  reply = ''
  requester.recv_string(reply)

  puts "Ackermann(#{m}, #{n}): #{reply}"
end
