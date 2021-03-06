require 'ffi-rzmq'
require 'json'
require 'mongo'

def ack(m, n)
  if m == 0
    n + 1
  elsif n == 0
    ack(m-1, 1)
  else
    ack(m-1, ack(m, n-1))
  end
end

def fib(n)
  if n < 2
    n
  else
    fib(n-1) + fib(n-2)
  end
end

def fac(n)
  (1..n).reduce(:*) || 1
end

puts "Starting Server..."

context = ZMQ::Context.new
socket  = context.socket(ZMQ::REP)
socket.bind("tcp://*:5555")

db    = Mongo::Connection.new.db('zmq-db')
coll  = db.collection('requests')

loop do
  request = ''
  socket.recv_string(request)

  coll.insert(JSON.parse(request))

  puts "Received request. Data: #{request.inspect}"
  req_json     = JSON.parse(request)
  req_function = req_json['function']

  case req_function
  when 'fib'
    socket.send_string(fib(req_json['n'].to_i).to_s)
  when 'fac'
    socket.send_string(fac(req_json['n'].to_i).to_s)
  when 'ack'
    socket.send_string(ack(req_json["m"].to_i, req_json["n"].to_i).to_s)
  else
    raise NotImplementedError
  end
end
