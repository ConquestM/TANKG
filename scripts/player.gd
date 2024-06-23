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
		if Input.is_action_pressed("ui_right"):
			rotation_degrees = 0
		if Input.is_action_pressed("ui_left"):
			rotation_degrees = 180
		$CollisionShape2D.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vert_direction:
		velocity.y = vert_direction * speed
		if Input.is_action_pressed("ui_up"):
			rotation_degrees = 270
		if Input.is_action_pressed("ui_down"):
			rotation_degrees = 90
		$CollisionShape2D.scale.x = vert_direction
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	if direction and vert_direction:
		if Input.is_action_pressed("ui_up") \
		and Input.is_action_pressed("ui_right"):
			rotation_degrees = 300
		if Input.is_action_pressed("ui_up") \
		and Input.is_action_pressed("ui_left"):
			rotation_degrees = 225
		if Input.is_action_pressed("ui_down") \
		and Input.is_action_pressed("ui_right"):
			rotation_degrees = 45
		if Input.is_action_pressed("ui_down") \
		and Input.is_action_pressed("ui_left"):
			rotation_degrees = 135
	move_and_slide()
	global_position.x = clamp(global_position.x, 0, screen_size.x
	 / get_parent().get_child(-1).zoom.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y
	 / get_parent().get_child(-1).zoom.y)

