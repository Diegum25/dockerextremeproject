class_name Manager extends Node

var socket = WebSocketPeer.new()

var websocket_url : String = Utils.getWebSocket()

@export var World : Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var status : Error = socket.connect_to_url(websocket_url)
	if(status != Error.OK):
		printerr("Manager could not connect to %s" % websocket_url)
		set_physics_process(false)
	else:
		print("Connected to %s" % websocket_url)

func _physics_process(delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	match(state):
		WebSocketPeer.State.STATE_CLOSED:
			var code : int = socket.get_close_code()
			printerr("Connection to websocket was closed with code %d" % code)
			if ( code == -1 ):
				printerr("Connection was not closed nicely :(")
			set_physics_process(false)
		WebSocketPeer.State.STATE_CLOSING:
			pass
		WebSocketPeer.State.STATE_CONNECTING:
			pass
		WebSocketPeer.State.STATE_OPEN:
			while socket.get_available_packet_count():
				var packet = socket.get_packet()
				if socket.was_string_packet():
					var packet_text = packet.get_string_from_utf8()
					var text=("< Got text data from server: %s" % packet_text)
				else:
					var text=("< Got binary data from server: %d bytes" % packet.size())

# Called every frame. 'delta' is the elapsed time since the previous frame.
# GET OUT
func _process(delta: float) -> void:
	pass
