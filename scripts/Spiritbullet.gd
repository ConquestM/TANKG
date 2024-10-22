extends Area2D
@export var explosion_scene: PackedScene
@onready var global = get_node("/root/global")
var direction = 0
var speed = 50
var despawn = 0
var mega_bullet
var home = 1
var friendly = false
 
func _ready():
	$HomeTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if home == 1:
		move_local_x(speed * delta)
		direction = (get_node("/root/Map/Player").global_position - global_position)
		var target_Rotation = direction.angle()
		rotation = lerp_angle(rotation, target_Rotation, 10 * delta)
	else:
		move_local_x(speed * delta * 3)

func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()


func _on_home_timer_timeout():
	home = 0
