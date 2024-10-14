extends Area2D
@export var explosion_scene: PackedScene
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 1000
var despawn = 0
var megabullet
var friendly = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if friendly:
		set_meta("player", 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	if not friendly:
		$Sprite2D.self_modulate -= Color(0,0.1,0.1,-0.1)
	
func _on_area_entered(area):
	if area.has_meta("Spawn"):
		queue_free()

	if area.has_meta("Player") and not friendly:
		global.HP -= 1
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 0.5
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
