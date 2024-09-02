extends Area2D
@export var spark3_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 290
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Meiosis.start()
func _on_meiosis_timeout():
	var spark3 = spark3_scene.instantiate()
	add_sibling(spark3)
	spark3.global_position =global_position
	spark3.rotation = global_rotation
	
	var spark3b = spark3_scene.instantiate()
	add_sibling(spark3b)
	spark3b.global_position = global_position
	spark3b.rotation = global_rotation+170
	
	var spark3c = spark3_scene.instantiate()
	add_sibling(spark3c)
	spark3c.global_position = global_position
	spark3c.rotation = global_rotation-170
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