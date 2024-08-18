extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var bullet_scene: PackedScene
@export var firetimer:Node
@onready var healthbar = $Healthbar
var health = 10 : set = _set_health

var Attack = 0

func _ready():
	firetimer.start()
	healthbar.init_health(health)
	
func _process(_delta):
	_set_health(health)
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if health <= 0:
		queue_free()
	
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
		Attack = 0
func _on_weaktimer_timeout():
	$CollisionShape2D/Area2D.set_visible(true)
	$CollisionShape2D/Area2D/Hitbox.disabled = false
	
func _set_health(value):
	if healthbar != null:
		healthbar.health = global.BossHP
	

