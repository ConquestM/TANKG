extends CharacterBody2D
@export var mega_bullet_scene: PackedScene
@export var shield_bullet_scene: PackedScene
@export var spawner_scene: PackedScene
@export var zombie_scene: PackedScene
@export var wall_scene: PackedScene
@export var attack_scene: PackedScene
@export var wall_attack_scene: PackedScene
@export var fire_timer:Node
@export var portal_scene: PackedScene
@onready var health_bar = $CanvasLayer/Healthbar
var screen_size = get_viewport_rect().size
var health = global.boss_3_hp : set = _set_health
var attack = 0
var wave_attack = 0

func _ready():
	$CanvasLayer/Label.hide()
	$CollisionShape2D/Firetimer.start()
	health_bar.init_health(health)
	global.spirits = 0


# Function that,
# 1. despawns the boss when its health is 0.
# 2. spawns the zombies when the variable is greater than 1.
# 3. plays the animated sprite's animaiton.
func _process(_delta):
	_set_health(health)
	if get_node_or_null("CollisionShape2D") == null: return
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.boss_3_hp <= 0:
		$CanvasLayer/Timer2.start()
		$CollisionShape2D/AnimatedSprite2D.queue_free()
		$CollisionShape2D.queue_free()
	if global.zombies >= 1:
		var rng = RandomNumberGenerator.new()
		var rnd_x = rng.randi_range(0, 570)
		var rnd_y = rng.randi_range(0, 370)
		var zombie = zombie_scene.instantiate()
		add_sibling(zombie)
		zombie.position = Vector2(rnd_x, rnd_y)
		global.zombies -= 1
		$CollisionShape2D/AnimatedSprite2D.play("default")
	if wave_attack == 1 and global.boss_3_hp <= 25:
		pass


# Function that does attacks.
# 1. Fires a bullet that spawns a gravestone and spawns 10 zombies with the previous function. 
# 2. spawns a spirit if there are less than 4.
func _on_firetimer_timeout():
	if attack <= 1:
		wave_attack += 0.5
	if attack < 1:
		var bullet = shield_bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		global.zombies += 10
		attack +=1
	else: 
		if global.spirits < 4:
			var rng = RandomNumberGenerator.new()
			var rnd_x = rng.randi_range(0, 570)
			var rnd_y = rng.randi_range(0, 370)
			var spawner = spawner_scene.instantiate()
			add_sibling(spawner)
			spawner.position = Vector2(rnd_x, rnd_y)
			attack = 0
			if global.wall_attack == 1:
				var wall_attack = wall_attack_scene.instantiate()
				wall_attack.global_position = $CollisionShape2D/AnimatedSprite2D/wallspawn.global_position
				wall_attack.rotation = $CollisionShape2D.rotation
				add_sibling(wall_attack)
				global.wall_attack = 0
		attack = 0


func _set_health(_value):
	if health_bar != null:
		health_bar.health = global.boss_3_hp


func _on_timer_timeout():
	$CanvasLayer/Label.hide()
	var portal = portal_scene.instantiate()
	add_sibling(portal)
	portal.global_position = get_node("../Camera2D").global_position


func _on_timer_2_timeout():
	$CanvasLayer/Label.show()
	$CanvasLayer/Timer.start()
