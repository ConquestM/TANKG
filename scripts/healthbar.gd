extends ProgressBar
@onready var global = get_node("/root/global")
@onready var timer = $Timer
@onready var damage_bar = $Damagebar
var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		timer.start()
	elif timer.is_stopped():
		damage_bar.value = health
		
	
func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _on_timer_timeout():
	damage_bar.value = health

func _process(_delta):
	rotation = -get_parent().rotation
