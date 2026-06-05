class_name GameInfo extends Control

@export var myText : Label

func changeText(text : String) -> void:
	myText.text = text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(myText)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
