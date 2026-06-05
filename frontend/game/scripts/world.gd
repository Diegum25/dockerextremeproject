class_name World extends Node3D

@export var manager : Manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(manager)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	pass
