extends Node2D

var can_shoot = true
@export var bullet_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Locks the rotation to the mouse. Locks the turret to the player. 
# Additionally, allows for the left click to fire a bullet.
func _process(_delta):
	look_at(get_global_mouse_position())
	global_rotation = rotation
	if Input.is_action_pressed("ui_left_click") and can_shoot:
		_shoot()
		can_shoot = false
		$Timer.start()
	position = get_node("/root/Map/Player").global_position


# Fuction to fire the bullet.
func _shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = $BulletSpawn.global_position
	bullet.global_rotation = global_rotation
	bullet.friendly = true
	get_parent().add_sibling(bullet)


# Cooldown for the fire.
func _on_timer_timeout():
	can_shoot = true 
