extends Area2D
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 290
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Meiosis.start()
	$Die.start()
func _on_meiosis_timeout():
	var megabullet2 = megabullet2_scene	.instantiate()
	add_sibling(megabullet2)
	megabullet2.global_position =global_position
	megabullet2.rotation = global_rotation
	
	var megabullet2a = megabullet2_scene.instantiate()
	add_sibling(megabullet2a)
	megabullet2a.global_position = global_position
	megabullet2a.rotation = global_rotation+170
	
	var megabullet2b = megabullet2_scene.instantiate()
	add_sibling(megabullet2b)
	megabullet2b.global_position = global_position
	megabullet2b.rotation = global_rotation-170
	$Meiosis.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(speed * delta)
	despawn += 1
	if despawn > 300:
		queue_free()
func _on_area_entered(area):
	if area.has_meta("Block"):
		queue_free()
	if area.has_meta("Player") and not friendly:
		global.HP -= 2
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		queue_free()



func _on_die_timeout():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
