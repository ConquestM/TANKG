extends Node2D
@export var bullet_scene: PackedScene
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(get_global_mouse_position())
	global_rotation = rotation
	if Input.is_action_just_pressed("ui_left_click") and can_shoot:
		_shoot()
		can_shoot = false
		$Timer.start()
	position = get_node("/root/Map/Player").global_position

func _shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = $BulletSpawn.global_position
	bullet.global_rotation = global_rotation
	bullet.friendly = true
	get_parent().add_sibling(bullet)
	
	
func _on_timer_timeout():
	can_shoot = true 
