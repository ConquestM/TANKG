extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("spawn")
	position.y = 0
	position.x = 610
	rotation = 0


func _on_despawn_timeout():
	global.wall_attack = 1
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
