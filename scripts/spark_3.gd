extends Area2D

@export var mega_bullet_scene: PackedScene
var speed = 270
var despawn = 0
var friendly = false
@onready var global = get_node("/root/global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the Spark, and despanws the spark in the right conditions.
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	if global.boss_hp == 0:
		queue_free()
	if despawn > 3000:
		queue_free()


# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()


# Despawns the spark on screen exit.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
