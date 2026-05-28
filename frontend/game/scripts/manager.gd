class_name Manager extends Node

var socket = WebSocketPeer.new()

var websocket_url : String = Utils.whereAmI()

@export var World : Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var status : Error = socket.connect_to_url(websocket_url)
	if(status != Error.OK):
		printerr("Manager could not connect to %s" % websocket_url)
		_exit_tree()

func _physics_process(delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	match(state):
		WebSocketPeer.State.STATE_CLOSED:
			var code : int = socket.get_close_code()
			printerr("Connection to websocket was closed with code %d" % code)
			if ( code == -1 ):
				printerr("Connection was not closed nicely :(")
			_exit_tree()
		WebSocketPeer.State.STATE_CLOSING:
			pass
		WebSocketPeer.State.STATE_CONNECTING:
			pass
		WebSocketPeer.State.STATE_OPEN:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# GET OUT
func _process(delta: float) -> void:
	pass
