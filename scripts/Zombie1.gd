extends CharacterBody2D
@export var grave_scene : PackedScene
@onready var global = get_node("/root/global")
var direction = 0
var speed = 50
var despawn = 0
var megabullet
var home = 1
var friendly = false
 
func _ready():
	global.zombies -=1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.BossHP == 0:
		queue_free()
	if home == 1:
		move_local_x(speed * delta)
		direction = (get_node("/root/Map/Player").global_position - global_position)
		var targetRotation = direction.angle()
		rotation = lerp_angle(rotation, targetRotation, 10 * delta)
	else:
		move_local_x(speed * delta * 3)

func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.HP -= 1
		global.iframes = true


func _on_die_timeout():
	var grave = grave_scene.instantiate()
	grave.global_position = global_position
	add_sibling(grave)
	queue_free()
