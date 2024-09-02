extends Area2D
@export var megabullet_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 270
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	if despawn > 3000:
		queue_free()
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly:
		global.HP -= 1
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()