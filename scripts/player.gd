extends CharacterBody2D
@export var speed = 100
@export var bullet_scene: PackedScene
var can_shoot = true
var dashing = false
var dash_duration = 0.1
var dash_timer = 0
var can_dash = true
var direction = 0
var vert_direction = 0
var slowed = 0
var saved_direction = 0
var saved_vert_direction = 0
var screen_size
var health = global.hp : set = _set_health
@onready var health_bar = $CanvasLayer/Healthbar


# Called when the node enters the scene tree for the first time.
func _ready():
# Sets the screensize and the player health.
	screen_size = get_viewport_rect().size
	health_bar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# The healthbar visuals updates every frame.
	_set_health(health)
	# Checks if you are not dashing.
	if not dashing:
		# Takes plater input for movment
		direction = Input.get_axis("ui_left", "ui_right")
		vert_direction = Input.get_axis("ui_up", "ui_down")
		# Normalizes direction so that diagonal movement isn't faster
		var norm_direction = Vector2(direction, vert_direction).normalized()
		direction = norm_direction.x
		vert_direction = norm_direction.y
	# Saves direction for dashing
	if direction > 0 or direction < 0 or vert_direction > 0 or vert_direction < 0:
		saved_direction = direction
		saved_vert_direction = vert_direction
	# Rotates the player
	if direction:
		velocity.x = direction * speed
		if Input.is_action_pressed("ui_right"):
			rotation_degrees = 0
		if Input.is_action_pressed("ui_left"):
			rotation_degrees = 180
		$CollisionShape2D.scale.x = direction
		$AnimatedSprite2D.play("default")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vert_direction:
		velocity.y = vert_direction * speed
		if Input.is_action_pressed("ui_up"):
			rotation_degrees = 270
		if Input.is_action_pressed("ui_down"):
			rotation_degrees = 90
		$CollisionShape2D.scale.x = vert_direction
		$AnimatedSprite2D.play("default")
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
	# Checks player input for dashing.
	if Input.is_action_just_pressed("dash"):
		if can_dash:
			_dash()
	# Tracks how long the player dash is
	if dashing:
		dash_timer += delta
		if dash_timer >= dash_duration:
			dashing = false
			if slowed == 1:
				speed = 50
			if slowed == 0:
				speed = 100
			dash_timer = 0
	# Actions taken when the player dies.
	if global.hp < 0 or global.hp == 0:
		sounds._battle_end()
		get_tree().change_scene_to_file("res://main_menu.tscn")
		global.hp = 99
	# Gives the player iframes.
	if dashing or global.iframes:
		$Area2D/CollisionShape2D.disabled = true
	if not dashing and not global.iframes:
		$Area2D/CollisionShape2D.disabled = false


# The function for dashing.
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

# Colldown for the dashing of the player.
func _on_timer_timeout():
	can_dash = true


# Function for visually updating the healthbar.
func _set_health(_value):
	if health_bar != null:
		health_bar.health = global.hp


# Gravestone aura effect. Slows down the player while in it and for a time once leaving it.
func _on_area_2d_area_entered(area):
	if area.has_meta("slow"):
		speed = 50
		slowed = 1
		$Slowtimer.start()


# Gravestone aura effect ending.
func _on_slowtimer_timeout():
	speed = 100
	slowed = 0
