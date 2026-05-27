extends Label3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(OS.has_feature("web")):
		self.text = "We are on the browser"
		$ws.browser()
	else:
		self.text = "We are on the machine"
		$ws.machine()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
