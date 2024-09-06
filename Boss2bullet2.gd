extends Area2D
@export var explosion_scene: PackedScene
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")
@export var Debt_scene: PackedScene
var wait = 0
var speed = 100
var despawn = 0
var megabullet
var friendly = false



func _ready():
	$Wait.start()
	if global.BossHP <= 40:
		self.visible = false
		speed = -400



func _process(delta):
	move_local_x(speed * delta)
	if global.back == 1:
		if wait == 1:
			speed = -100
		$VertHor.start()
	if global.back == 0:
		if wait == 1:
			speed = 100

	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)
	
func _on_area_entered(area):
	if wait == 1:
		if area.has_meta("Spawn"):
			queue_free()
		if area.has_meta("Tile"):
			queue_free()	
		if area.has_meta("Player") and not friendly:
			global.HP -= 1
			queue_free()
		if area.has_meta("Boss") and friendly:
			global.BossHP -= 1
			queue_free()
		if area.has_meta("Debt"):
			if not friendly:
				for i in 20:
					var megabulletb = megabullet2_scene	.instantiate()
					add_sibling(megabulletb)
					megabulletb.global_position = global_position
					megabulletb.rotation_degrees = global_rotation_degrees + i*18
					queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	$Debt.start()

func _on_debt_timeout():
		queue_free()


func _on_wait_timeout():
	wait = 1
	self.visible = true

