extends Area2D
@export var megabullet2_scene: PackedScene

# Called when the node enters the scene tree for the first time.
# Displays position for knowledge.
func _ready():
	print(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Spawns bullets around the teleport, to guide the player away.
func _on_timer_timeout():
	for i in 20:
		var megabulletb = megabullet2_scene	.instantiate()
		add_sibling(megabulletb)
		megabulletb.position = position
		megabulletb.rotation_degrees = rotation_degrees + i*18

# Despawns the Teleport once its use is over.
func _on_timer_2_timeout():
	queue_free()
