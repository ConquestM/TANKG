extends Area2D
@export var megabullet_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 200
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Meiosis.start()
func _on_meiosis_timeout():
	var megabullet = megabullet_scene.instantiate()
	megabullet.global_position = $Megabullet.global_position
	megabullet.rotation = global_rotation
	add_sibling(megabullet)
	var megabullet2 = megabullet_scene.instantiate()
	megabullet2.global_position = $Megabullet.global_position
	megabullet2.rotation = global_rotation+170
	add_sibling(megabullet2)
	var megabullet3 = megabullet_scene.instantiate()
	megabullet3.global_position = $Megabullet.global_position
	megabullet3.rotation = global_rotation-170
	add_sibling(megabullet3)
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
		print("pd")
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		print("bd")
		queue_free()

