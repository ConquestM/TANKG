extends Node2D


# Called when the node enters the scene tree for the first time.
# Sets the position of the wall.
func _ready():
	position.y = 0
	position.x = 610
	rotation = 0

# Despawns the wall, and notifies the boss of this.
func _on_despawn_timeout():
	global.wall_attack = 1
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Despawns the wall if the boss is dead.
func _process(_delta):
	if global.boss_3_hp == 0:
		queue_free()
