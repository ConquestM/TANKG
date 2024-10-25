extends AnimatedSprite2D
# This code sets the animated sprite's rotation to 0. 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Sets the rotation of the sprite to 0, effectively making it upright.
func _process(_delta):
	global_rotation = 0

