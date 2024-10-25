extends Area2D

@export var explosion_scene: PackedScene
var direction = 0
var speed = 50
var despawn = 0
var mega_bullet
var home = 1
var friendly = false
@onready var global = get_node("/root/global")

# Starts the timer for homing to change.
func _ready():
	$HomeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Despawns the bullet if the boss is dead, and makes the bullet home towards the player.
# Moves the bullet.
func _process(delta):
	if global.boss_3_hp == 0 or global.hp == 99:
		queue_free()
	if home == 1:
		move_local_x(speed * delta)
		if get_node_or_null("CollisionShape2D") == null: return
		direction = (get_node("/root/Map/Player").global_position - global_position)
		var target_Rotation = direction.angle()
		rotation = lerp_angle(rotation, target_Rotation, 10 * delta)
	else:
		move_local_x(speed * delta * 3)

# Damages the player.
func _on_area_entered(area):
	if area.has_meta("Player") and not friendly and not global.iframes:
		global.hp -= 1
		global.iframes = true
		queue_free()

# Stops the ability to home.
func _on_home_timer_timeout():
	home = 0

# Despawns the bullet.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

