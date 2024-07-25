extends CharacterBody2D

@export var speed = 100
var screen_size
@export var bullet_scene: PackedScene
var can_shoot = true
var dashing = false
var dash_duration = 0.1
var dash_timer = 0
var can_dash = true
var direction = 0
var vert_direction = 0
var saved_direction = 0
var saved_vert_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dashing:
		direction = Input.get_axis("ui_left", "ui_right")
		vert_direction = Input.get_axis("ui_up", "ui_down")
		var norm_direction = Vector2(direction, vert_direction).normalized()
		direction = norm_direction.x
		vert_direction = norm_direction.y
	if direction > 0 or direction < 0 or vert_direction > 0 or vert_direction < 0:
		saved_direction = direction
		saved_vert_direction = vert_direction
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
	 / get_parent().get_child(0).zoom.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y
	 / get_parent().get_child(0).zoom.y)
	if Input.is_action_just_pressed("dash"):
		if can_dash:
			_dash()
	if dashing:
		dash_timer += delta
		if dash_timer >= dash_duration:
			dashing = false
			speed = 100
			dash_timer = 0
	if global.HP < 0 or global.HP == 0:
		get_tree().change_scene_to_file("res://Level.tscn")
		global.HP = 15
	if dashing:
		$Area2D/CollisionShape2D.disabled = true
	if not dashing:
		$Area2D/CollisionShape2D.disabled = false

func _dash():
	if dashing: return
	if Input.is_action_pressed("dash"):
		dashing = true
		if direction == 0 and vert_direction == 0:
			speed = 500
		else:
			speed = 1000
		direction = saved_direction
		vert_direction = saved_vert_direction
		can_dash = false
		$Timer.start()

func _on_timer_timeout():
	$Area2D/CollisionShape2D.disabled = false
	can_dash = true

