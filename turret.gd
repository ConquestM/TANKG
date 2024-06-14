extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	look_at(get_node("/root/Node2D2/PLayer").global_position)
