var websocket = require("websocket").server;
var http = require("http");

// init websocket
var port = 9600;
var connections = [];
var server = http.createServer();
server.listen(port, function(){
	console.log("server listening on port " + port);
});
var ws_server = new websocket({
	httpServer: server
});
// handle requests
ws_server.on("request", function(req){
	let connection = req.accept(null, req.origin);
	connections.push(connection);
	connection.on("message", function(message){
		for(let i = 0; i < connections.length; i++){
			connections[i].sendUTF(message.utf8Data);
		}
	});
});