extends Area2D
@export var explosion_scene: PackedScene
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")
@export var debt_scene: PackedScene
var wait = 0
var speed = 50
var despawn = 0
var megabullet
var friendly = false

# Function for movement, change in movement, colour change and despawning when there is no boss.
func _process(delta):
	move_local_x(speed * delta)
	if global.back == 1:
		if wait == 1:
			speed = -50
		$VertHor.start()
	if global.boss2hp == 0:
		queue_free()
	if global.back == 0:
		if wait == 1:
			speed = 50
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)

# Damage function, also codes for the detonation.
func _on_area_entered(area):
		if area.has_meta("Spawn"):
			queue_free()
		if area.has_meta("Tile"):
			queue_free()	
		if area.has_meta("Player") and not friendly:
			global.hp -= 1
			queue_free()
		if area.has_meta("Boss") and friendly:
			global.bosshp -= 1
			queue_free()
		if area.has_meta("Debt"):
			if not friendly:
				for i in 20:
					var megabulletb = megabullet2_scene	.instantiate()
					add_sibling(megabulletb)
					megabulletb.global_position = global_position
					megabulletb.rotation_degrees = global_rotation_degrees + i*18
					queue_free()

# Begins the despawn timer when exiting the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	$Debt.start()

# Despawns the bullet/subject.
func _on_debt_timeout():
		queue_free()


