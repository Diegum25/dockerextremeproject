# This is all very hardcoded
class_name Menu extends Control

@export var manager : Manager

func reset() -> void:
	invisible()
	enableSet($MainMenu)
	
func message(msg : String) -> void:
	invisible()
	enableSet($GameInfo)
	$GameInfo/Panel/Label.text = msg
	await get_tree().create_timer(3).timeout
	reset()

func invisible() -> void:
	for child : Node in get_children():
		if (child.is_class('Control')):
			child.visible = false
			
func enableSet(set : Control) -> void:
	set.visible = true
	set.position = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(manager)
	invisible()
	enableSet($MainMenu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_find_pressed() -> void:
	invisible()
	enableSet($Finding)
	var status : Error = await manager.sockConnect()
	if (status != Error.OK):
		invisible()
		enableSet($GameInfo)
		$GameInfo/Panel/Label.text = "Could\nnot connect\n:("
		await get_tree().create_timer(3).timeout
		reset()
	else:
		invisible()
