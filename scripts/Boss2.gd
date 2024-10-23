extends CharacterBody2D
@export var bullet_scene: PackedScene
@export var bullet_hell_scene: PackedScene
@export var bullet_hell_2_scene: PackedScene
@export var teleport_scene: PackedScene
@export var line_scene: PackedScene
@export var fire_timer:Node
@onready var health_bar = $CanvasLayer/Healthbar
var health = global.boss_2_hp : set = _set_health
var Attack = 0


func _ready():
	$CollisionShape2D/Firetimer.start()
	health_bar.init_health(health)
	global.wall = 6 


# Makes the boss look at the player, for attack purposes.
# Also despawns the boss when health is low and plays the animated sprite.
func _process(_delta):
	_set_health(health)
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.boss_2_hp <= 0:
		queue_free()
	$AnimatedSprite2D.play("default")


# Function for the Attacks
# 1. Spawns the lines that rotate.
func _on_firetimer_timeout():
	if global.wall > 1 :
		for i in 3:
			var line = line_scene.instantiate()
			line.rotation_degrees = $CollisionShape2D.rotation_degrees -(120)*(i-1)
			add_sibling(line)
			global.wall = 0
# Spawns the continous waves of bullets.
	if Attack < 3:
		for i in 36:
			var bullet_hell = bullet_hell_scene.instantiate()
			bullet_hell.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			bullet_hell.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
			add_sibling(bullet_hell)
		Attack +=1
		$CollisionShape2D/Firetimer.start()
		global.back = 0
# Spawns the reverse bullets when below a certain health value.
		if global.boss_2_hp <= 50 * global.boss_hp_mult:
			for i in 36:
				var bullet_hell_2 = bullet_hell_2_scene.instantiate()
				bullet_hell_2.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
				bullet_hell_2.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
				add_sibling(bullet_hell_2)
# Spawns the bullet that leads to the *black* circle to spawn.
	else:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		Attack = 0
		global.back = 1

# Makes the healthbar reflect the variable.
func _set_health(_value):
	if health_bar != null:
		health_bar.health = global.boss_2_hp
