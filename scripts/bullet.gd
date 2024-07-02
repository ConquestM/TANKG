extends Area2D
@export var explosion_scene: PackedScene
@onready var global = get_node("/root/global")

var speed = 500
var despawn = 0

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
	#if area.has_meta("Boss") and not friendly:
