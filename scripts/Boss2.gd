extends CharacterBody2D
@export var megabullet_scene: PackedScene
@export var bullet_scene: PackedScene
@export var bullethell_scene: PackedScene
@export var bullethell2_scene: PackedScene
@export var teleport_scene: PackedScene
@export var firetimer:Node
@export var portal_scene: PackedScene
@onready var healthbar = $CanvasLayer/Healthbar
var health = global.Boss2HP : set = _set_health

var Attack = 0

func _ready():
	firetimer.start()
	healthbar.init_health(health)
	$CanvasLayer/Label.hide()
	
func _process(_delta):
	_set_health(health)
	if get_node_or_null("CollisionShape2D") == null: return
	$CollisionShape2D.look_at(get_node("/root/Map/Player").global_position)
	if global.Boss2HP <= 0:
		$CanvasLayer/Timer2.start()
		$CollisionShape2D.queue_free()
		
func _on_firetimer_timeout():
	if Attack < 3:
		for i in 36:
			var bullethell = bullethell_scene.instantiate()
			bullethell.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
			bullethell.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
			add_sibling(bullethell)
		$CollisionShape2D/Area2D.set_visible(false)
		Attack +=1
		$CollisionShape2D/Firetimer.start()
		global.back = 0
		if global.Boss2HP <= 50 * global.BossHPMult:
			for i in 36:
				var bullethell2 = bullethell2_scene.instantiate()
				bullethell2.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
				bullethell2.rotation_degrees = $CollisionShape2D.rotation_degrees-10*i
				add_sibling(bullethell2)
				$CollisionShape2D/Area2D.set_visible(false)
	else:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $CollisionShape2D/Boss_bullet_spawn.global_position
		bullet.rotation = $CollisionShape2D.rotation
		add_sibling(bullet)
		$CollisionShape2D/Area2D.set_visible(false)
		$CollisionShape2D/Area2D/Hitbox.disabled = true
		$CollisionShape2D/Firetimer.start()
		$CollisionShape2D/Weaktimer.start()
		Attack =0
		global.back = 1

func _on_weaktimer_timeout():
	$CollisionShape2D/Area2D.set_visible(true)
	$CollisionShape2D/Area2D/Hitbox.disabled = false
	
func _set_health(value):
	if healthbar != null:
		healthbar.health = global.Boss2HP

func _on_timer_timeout():
	$CanvasLayer/Label.hide()
	var portal = portal_scene.instantiate()
	add_sibling(portal)
	portal.global_position = get_node("../Camera2D").global_position

func _on_timer_2_timeout():
	$CanvasLayer/Label.show()
	$CanvasLayer/Timer.start()
