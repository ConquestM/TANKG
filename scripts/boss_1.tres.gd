extends CharacterBody2D

@export var mega_bullet_scene: PackedScene
@export var bullet_scene: PackedScene
@export var fire_timer:Node
@export var portal_scene: PackedScene
@export var lightning_scene: PackedScene
var health = global.boss_hp : set = _set_health
var Attack = 0
@onready var health_bar = $CanvasLayer/Healthbar


# Hides the boss slain label, and sets the level.
# Also sets variables for health.
func _ready():
	global.level = 1 
	$CanvasLayer/Label.hide()
	health_bar.init_health(health)


# Updates the health bar, and begins the boss defeated code when boss is defeated.
# Also makes the boss target the player.
func _process(_delta):
	_set_health(health)
	if get_node_or_null("CollisionShape2D") == null: return
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.boss_hp <= 0:
		$CanvasLayer/Timer2.start()
		$Sprite2D.queue_free()
		$CollisionShape2D.queue_free()


# Codes for the attacks of the boss.
func _on_firetimer_timeout():
	if Attack < 3:
		# The circular bolt attack.
		for i in 36:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			bullet.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
			add_sibling(bullet)
		$CollisionShape2D/Firetimer.start()
		Attack +=1
	else:
		# The wave of sparks attack.
		var mega_bullet = mega_bullet_scene.instantiate()
		mega_bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		mega_bullet.rotation = $CollisionShape2D.rotation
		add_sibling(mega_bullet)
		var mega_bullet_2 = mega_bullet_scene.instantiate()
		mega_bullet_2.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		mega_bullet_2.rotation = $CollisionShape2D.rotation+170
		add_sibling(mega_bullet_2)
		var mega_bullet_3 = mega_bullet_scene.instantiate()
		mega_bullet_3.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		mega_bullet_3.rotation = $CollisionShape2D.rotation-170
		add_sibling(mega_bullet_3)
		$CollisionShape2D/Firetimer.start()
		Attack = 0
		global.lightning = 1
		# Spawns a column of lightning.
		var lightning = lightning_scene.instantiate()
		lightning.global_position = get_node("/root/Map/Player").global_position
		add_sibling(lightning)


# Updates the health bar
func _set_health(_value):
	if health_bar != null:
		health_bar.health = global.boss_hp

# Function for the 'cutscene' when the boss is defeated.
func _on_timer_timeout():
	$CanvasLayer/Label.hide()
	var portal = portal_scene.instantiate()
	add_sibling(portal)
	portal.global_position = get_node("../Camera2D").global_position


# Another function for the boss defeated 'cutscene'
func _on_timer_2_timeout():
	$CanvasLayer/Label.show()
	$CanvasLayer/Timer.start()
