// connect to websocket
var ws_uri = "ws://localhost:9600";
var websocket = new WebSocket(ws_uri);

// socket open:
websocket.onopen = function(event){
	addmessage('<div class="message green">you have joined the chat.</div>');
};

// socket close:
websocket.onclose = function(event){
	addmessage('<div class="message blue">you got disconnected.</div>');
};

// socket error:
websocket.onerror = function(event){
	addmessage('<div class="message red">chat connection failed.</div>');
};

// handle messages (client)
websocket.onmessage = function(event){
	var data = JSON.parse(event.data);
    if(data.type == "message"){
		addmessage('<div class="message">' + data.username + ': ' + data.message + '</div>');
 	}
};

// handle messages (server)
document.getElementById("chat-form").addEventListener("submit", function(event){
	event.preventDefault();
	var message_element = document.getElementsByTagName("input")[0];
	var message = message_element.value;
	if(message.toString().length){
		var username = localStorage.getItem("username");
		var data = {
			type: "message",
			username: username,
			message: message
		};
		websocket.send(JSON.stringify(data));
		message_element.value = "";
	}
}, false);

// utils
function username(){
	var username = window.prompt("enter username:", "");
	if(username.toString().length > 2){
		localStorage.setItem("username", username);
	}
	else{
		alert("Your username must be at least two characters.");
		username();
	}
}
username();

function addmessage(message){
	var chat_messages = document.getElementById("chat-messages");
	chat_messages.insertAdjacentHTML("beforeend", message);
	chat_messages.scrollTop = chat_messages.scrollHeight;
}