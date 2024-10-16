extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var shield_bullet_scene: PackedScene
@export var spawner_scene: PackedScene
@export var zombie_scene: PackedScene
@export var wall_scene: PackedScene
@export var firetimer:Node
@onready var healthbar = $Healthbar
var screenSize = get_viewport_rect().size
var rng = RandomNumberGenerator.new()
var rndX = 390
var rndY = 357
var health = global.Boss3HP : set = _set_health

var Attack = 0

func _ready():
	firetimer.start()
	healthbar.init_health(health)
	
func _process(_delta):
	_set_health(health)
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.BossHP <= 0:
		queue_free()
	if global.zombies >= 1:
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, 570)
		var rndY = rng.randi_range(0, 370)
		var zombie = zombie_scene.instantiate()
		add_sibling(zombie)
		zombie.position = Vector2(rndX, rndY)
		global.zombies -= 1
func _on_firetimer_timeout():
	if Attack < 1:
		var bullet = shield_bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()

		global.zombies += 10
		Attack +=1
	else: 
		if global.spirits <4:
			var rng = RandomNumberGenerator.new()
			var rndX = rng.randi_range(0, 570)
			var rndY = rng.randi_range(0, 370)
			var spawner = spawner_scene.instantiate()
			add_sibling(spawner)
			spawner.position = Vector2(rndX, rndY)
			Attack = 0

		Attack = 0

func _set_health(value):
	if healthbar != null:
		healthbar.health = global.Boss3HP

