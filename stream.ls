http = require('http').create-server!
sock = require('sockjs').create-server!
r = require('redis'); r0 = r.create-client!; r1 = r.create-client!

sockets = {}

r0.psubscribe 'out:*'
r0.on 'pmessage', (_pattern, channel, message) ->
  [_out, uuid] = channel / ':'
  sockets[uuid].write message

sock.on 'connection', (c) ->
  sockets[c.id] = c

  c.on 'data', (message) ->
    r1.publish "in:#{c.id}", message

  c.on 'close', ->
    delete sockets[c.id]

sock.install-handlers http,
  prefix: '/stream'

http.listen 1025, '127.0.0.1'
