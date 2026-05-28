extends Label3D

var labelSon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func browser():
	var host = String(JavaScriptBridge.eval("window.location.origin"))
	var wshost = "wss"+host.lstrip('https')
	
	self.text = "at %s
	connecting to %s" % [host, wshost]
	
	labelSon = SocketTest.new()
	
	labelSon.websocket_url = wshost+'/api/ws/'
	labelSon.position.y -= 0.5
	
	self.add_child(labelSon)

func machine():
	self.text = "hi idk how to set the frontend env variable for this thing
	but i can do this %s" % OS.get_environment("HOME")
	labelSon = SocketTest.new()
	
	labelSon.websocket_url = 'ws://localhost:4001/' # this is the exposed local ws
	labelSon.position.y -= 0.5
	
	self.add_child(labelSon)
