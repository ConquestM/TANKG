extends CharacterBody2D

@export var speed = 100
var screen_size
@export var bullet_scene: PackedScene
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	var vert_direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction * speed
		if direction > 0:
			rotation_degrees = 0
		if direction < 0:
			rotation_degrees = 180
		$CollisionShape2D.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vert_direction:
		velocity.y = vert_direction * speed
		if vert_direction < 0:
			rotation_degrees = 270
		if vert_direction > 0:
			rotation_degrees = 90
		$CollisionShape2D.scale.x = direction
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	global_position.x = clamp(global_position.x, 0, screen_size.x
	 / get_parent().get_child(-1).zoom.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y
	 / get_parent().get_child(-1).zoom.y)
	if Input.is_action_just_pressed("ui_left_click") and can_shoot:
		_shoot()
		can_shoot = false
		$Timer.start()

func _shoot():
	var bullet = bullet_scene.instantiate()
	add_sibling(bullet)
	bullet.global_position = $BulletSpawn.global_position
	bullet.rotation_degrees = rotation_degrees
	
func _on_timer_timeout():
	can_shoot = true 
