extends SubViewport

@export var rect : ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(rect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.size = rect.size
