extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Locks rotation of the AnimatedSprite2D.
func _process(_delta):
	global_rotation = 0