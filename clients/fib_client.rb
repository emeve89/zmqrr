require 'ffi-rzmq'
require 'json'

context = ZMQ::Context.new

puts 'Connecting to the AckFibFac Server...'
requester = context.socket(ZMQ::REQ)
requester.connect('tcp://localhost:5555')

loop do
  n = rand(20) + 1
  fib_request = { fn: 'fib', n: n }

  puts "Computing Fibonacci(#{n})"
  requester.send_string fib_request.to_json

  reply = ''
  requester.recv_string(reply)

  puts "Fibonacci(#{n}): #{reply}"
end
