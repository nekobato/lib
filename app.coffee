_ = require 'underscore'

app = require('http').createServer(handler)
io = require 'socket.io'.listen(app)

app.listen(3000)

io.sockets.on 'connection', (sock) ->
	
