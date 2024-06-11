extends CharacterBody2D

var direction: Vector2
func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
func _process(delta):
	velocity += direction * 100 * delta
	move_and_slide()
