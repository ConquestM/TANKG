extends Area2D


# Called when the node enters the scene tree for the first time.
# Primes the hitbox for detonation and for despawning.
func _ready():
	set_meta("Debt2", 0)
	$Delete.start()
	print(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Despawns the hitbox.
func _on_delete_timeout():
	queue_free()

# Despawns the hitbox when coming into contact with its target.
func _on_area_entered(area):
	if area.has_meta("Circle"):
		queue_free()
