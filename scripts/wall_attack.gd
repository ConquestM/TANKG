extends CharacterBody2D

const MOVE = 45
@export var bullet_scene: PackedScene
@export var fire_timer:Node
@export var speed = 100
var Attack = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Despawns the wall if the boss is dead.
# Moves the wall.
func _process(_delta):
	position.x -= MOVE * _delta
	if global.boss_3_hp == 0:
		queue_free()

# Spawns bullets.
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.rotation = rotation
		get_parent().get_parent().add_sibling(bullet)
		bullet.global_position = $Boss_bullet_spawn.global_position
		$Firetimer.start()
		Attack +=1
	else:
		Attack = 0

# Despawns the wall on exiting the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
