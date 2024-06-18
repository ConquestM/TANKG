extends CharacterBody2D

@export var speed = 100
var screen_size
@export var bullet_scene: PackedScene
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	var vert_direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction * speed
		$CollisionShape2D.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vert_direction:
		velocity.y = vert_direction * speed
		$CollisionShape2D.scale.x = direction
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	global_position.x = clamp(global_position.x, 0, screen_size.x
	 / get_parent().get_child(-1).zoom.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y
	 / get_parent().get_child(-1).zoom.y)

