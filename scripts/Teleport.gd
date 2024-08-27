extends Area2D
@export var megabullet2_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	print(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in 20:
		var megabulletb = megabullet2_scene	.instantiate()
		add_sibling(megabulletb)
		megabulletb.position = position
		megabulletb.rotation_degrees = rotation_degrees + i*18


func _on_timer_2_timeout():
	queue_free()
