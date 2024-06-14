extends Area2D
var speed = 500
var despawn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	despawn += 1
	move_local_x(speed * delta) 
	if despawn > 500:
		queue_free()
