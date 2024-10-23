extends CharacterBody2D
@export var bullet_scene: PackedScene
@export var fire_timer:Node
@export var speed = 100
var screen_size
var Attack = 0


func _process(_delta):
	position.x -= 45 * _delta


func _on_area_2d_area_entered(area):
	if area.has_meta("Ghost"):
		pass


func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $Boss_bullet_spawn.global_position
		bullet.rotation = rotation
		add_sibling(bullet)
		$Firetimer.start()
		Attack +=1
	else:
		Attack = 0


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
