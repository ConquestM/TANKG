extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var bullet_scene: PackedScene

@export var firetimer:Node

var Attack = 0

func _ready():
	firetimer.start()
	
func _process(_delta):
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	
	
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Area2D.set_visible(false)
		$CollisionShape2D/Area2D/Hitbox.disabled = true
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack +=1
	else:
		for i in 20:
			var megabullet = megabullet_scene.instantiate()
			megabullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			megabullet.rotation_degrees = $CollisionShape2D.rotation_degrees +i*18
			add_sibling(megabullet)

		$CollisionShape2D/Area2D.set_visible(false)
		$CollisionShape2D/Area2D/Hitbox.disabled = true
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack = 0
func _on_weaktimer_timeout():
	$CollisionShape2D/Area2D.set_visible(true)
	$CollisionShape2D/Area2D/Hitbox.disabled = false
