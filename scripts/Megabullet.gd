extends Area2D
@export var megabulletb_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 200
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Meiosis.start()
func _on_meiosis_timeout():
	var megabulletb = megabulletb_scene.instantiate()
	megabulletb.global_position = $Megabullet.global_position
	megabulletb.rotation = global_rotation
	add_sibling(megabulletb)
	var megabullet2b = megabulletb_scene.instantiate()
	megabullet2b.global_position = $Megabullet.global_position
	megabullet2b.rotation = global_rotation+170
	add_sibling(megabullet2b)
	var megabullet3b = megabulletb_scene.instantiate()
	megabullet3b.global_position = $Megabullet.global_position
	megabullet3b.rotation = global_rotation-170
	add_sibling(megabullet3b)
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
		global.HP -= 5
		print("pd")
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		print("bd")
		queue_free()

