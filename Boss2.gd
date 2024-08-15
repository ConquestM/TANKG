extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var bullet_scene: PackedScene
@export var teleport_scene: PackedScene
@export var firetimer:Node
@onready var healthbar = $Healthbar
var screenSize = get_viewport_rect().size
var rng = RandomNumberGenerator.new()
var rndX = rng.randi_range(0, screenSize.x)
var rndY = rng.randi_range(0, screenSize.y)
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
	if Attack < 4:
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
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, 570)
		var rndY = rng.randi_range(0, 370)
		var teleport = teleport_scene.instantiate()
		add_sibling(teleport)
		teleport.position = Vector2(rndX, rndY)
		print(rndX)
		print(rndY)
		$Teletimer.start()
		Attack = 0
		#for i in 20:
			#var megabullet = megabullet_scene.instantiate()
			#megabullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			#megabullet.rotation_degrees = $CollisionShape2D.rotation_degrees +i*18
			#add_sibling(megabullet)

		$CollisionShape2D/Area2D.set_visible(false)
		$CollisionShape2D/Area2D/Hitbox.disabled = true
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack = 0
func _on_weaktimer_timeout():
	$CollisionShape2D/Area2D.set_visible(true)
	$CollisionShape2D/Area2D/Hitbox.disabled = false
	
func _set_health(value):
	if healthbar != null:
		healthbar.health = global.BossHP

func _on_teletimer_timeout():
	global_position = Vector2(rndX, rndY)
