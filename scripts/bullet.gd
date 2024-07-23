extends Area2D
@export var explosion_scene: PackedScene
@export var megabullet2_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 500
var despawn = 0
var megabullet
var friendly = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if not friendly:
		var hitbox = explosion_scene.instantiate()
		hitbox.global_position = get_node("/root/Map/Player").global_position
		hitbox.rotation = rotation+1.5
		add_sibling(hitbox)


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
		global.HP -= 1
		queue_free()
	if area.has_meta("Boss") and friendly:
		global.BossHP -= 1
		queue_free()
	if area.has_meta("Debt"):
		print("det")
	var megabulletb = megabullet2_scene	.instantiate()
	add_sibling(megabulletb)
	megabulletb.global_position = global_position
	megabulletb.rotation = global_rotation
	
	var megabullet2b = megabullet2_scene.instantiate()
	add_sibling(megabullet2b)
	megabullet2b.global_position = global_position
	megabullet2b.rotation = global_rotation+10
	
	var megabullet3b = megabullet2_scene.instantiate()
	add_sibling(megabullet3b)
	megabullet3b.global_position = global_position
	megabullet3b.rotation = global_rotation-10
	
	var megabullet4b = megabullet2_scene.instantiate()
	add_sibling(megabullet4b)
	megabullet4b.global_position = global_position
	megabullet4b.rotation = global_rotation-20
	
	var megabullet5b = megabullet2_scene.instantiate()
	add_sibling(megabullet5b)
	megabullet5b.global_position = global_position
	megabullet5b.rotation = global_rotation+20
	
	var megabullet6b = megabullet2_scene.instantiate()
	add_sibling(megabullet6b)
	megabullet6b.global_position = global_position
	megabullet6b.rotation = global_rotation-30
	
	var megabullet7b = megabullet2_scene.instantiate()
	add_sibling(megabullet7b)
	megabullet7b.global_position = global_position
	megabullet7b.rotation = global_rotation+30
	
	var megabullet8b = megabullet2_scene.instantiate()
	add_sibling(megabullet8b)
	megabullet8b.global_position = global_position
	megabullet8b.rotation = global_rotation-40
	
	var megabullet9b = megabullet2_scene.instantiate()
	add_sibling(megabullet9b)
	megabullet9b.global_position = global_position
	megabullet9b.rotation = global_rotation+40
	
	var megabullet10b = megabullet2_scene.instantiate()
	add_sibling(megabullet10b)
	megabullet10b.global_position = global_position
	megabullet10b.rotation = global_rotation-50
	
	var megabullet11b = megabullet2_scene.instantiate()
	add_sibling(megabullet11b)
	megabullet11b.global_position = global_position
	megabullet11b.rotation = global_rotation+50
	
	var megabullet12b = megabullet2_scene.instantiate()
	add_sibling(megabullet12b)
	megabullet12b.global_position = global_position
	megabullet12b.rotation = global_rotation-60
	
	var megabullet13b = megabullet2_scene.instantiate()
	add_sibling(megabullet13b)
	megabullet13b.global_position = global_position
	megabullet13b.rotation = global_rotation+60
	
	var megabullet14b = megabullet2_scene.instantiate()
	add_sibling(megabullet14b)
	megabullet14b.global_position = global_position
	megabullet14b.rotation = global_rotation-70
	
	var megabullet15b = megabullet2_scene.instantiate()
	add_sibling(megabullet15b)
	megabullet15b.global_position = global_position
	megabullet15b.rotation = global_rotation+70
	
	var megabullet16b = megabullet2_scene.instantiate()
	add_sibling(megabullet16b)
	megabullet16b.global_position = global_position
	megabullet16b.rotation = global_rotation-80
	
	var megabullet17b = megabullet2_scene.instantiate()
	add_sibling(megabullet17b)
	megabullet17b.global_position = global_position
	megabullet17b.rotation = global_rotation+80
	
	var megabullet18b = megabullet2_scene.instantiate()
	add_sibling(megabullet18b)
	megabullet18b.global_position = global_position
	megabullet18b.rotation = global_rotation-90
	
	var megabullet19b = megabullet2_scene.instantiate()
	add_sibling(megabullet19b)
	megabullet19b.global_position = global_position
	megabullet19b.rotation = global_rotation+90

	queue_free()
