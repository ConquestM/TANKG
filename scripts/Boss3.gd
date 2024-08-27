extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var shield_bullet_scene: PackedScene
@export var spawner_scene: PackedScene
@export var firetimer:Node
@onready var healthbar = $Healthbar
var screenSize = get_viewport_rect().size
var rng = RandomNumberGenerator.new()
var rndX = 390
var rndY = 357
var health = 50 : set = _set_health

var Attack = 0

func _ready():
	firetimer.start()
	global.BossHP = 50
	healthbar.init_health(health)
	
func _process(_delta):
	_set_health(health)
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.BossHP <= 0:
		queue_free()
		
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = shield_bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack +=1
	else: 
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, 570)
		var rndY = rng.randi_range(0, 370)
		var spawner = spawner_scene.instantiate()
		add_sibling(spawner)
		spawner.position = Vector2(rndX, rndY)
		Attack = 0
		#for i in 20:
			#var megabullet = megabullet_scene.instantiate()
			#megabullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			#megabullet.rotation_degrees = $CollisionShape2D.rotation_degrees +i*18
			#add_sibling(megabullet)
		Attack = 0

func _set_health(value):
	if healthbar != null:
		healthbar.health = global.BossHP
