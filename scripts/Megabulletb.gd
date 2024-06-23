extends Area2D
@export var megabulletc_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 200
var despawn = 0
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Meiosis.start()
func _on_meiosis_timeout():
	var megabulletc = megabulletc_scene.instantiate()
	add_sibling(megabulletc)
	megabulletc.global_position = global_position
	megabulletc.rotation = global_rotation
	
	var megabullet2c = megabulletc_scene.instantiate()
	add_sibling(megabullet2c)
	megabullet2c.global_position = global_position
	megabullet2c.rotation = global_rotation+170
	
	var megabullet3c = megabulletc_scene.instantiate()
	add_sibling(megabullet3c)
	megabullet3c.global_position = global_position
	megabullet3c.rotation = global_rotation-170
	
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
func _on_Apoptosis_timeout():
	queue_free()
