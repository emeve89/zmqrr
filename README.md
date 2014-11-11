Steps to run the code
=====================

1) Run ``brew install zmq`` from a terminal window.
2) Clone the repo
3) Once you get into the folder you cloned it, it will create a gemset to install there the dependencies.
4) Run **bundle install**

*Open at least two terminals (one to run the server, and the others to run the clients)*

Server
------

Run ``ruby server/server.rb``

Clients
-------

Run ``ruby clients/ack_client.rb``
Run ``ruby clients/fac_client.rb``
Run ``ruby clients/fib_client.rb`
