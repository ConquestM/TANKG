extends Area2D

const DAMAGE = 3
# Called when the node enters the scene tree for the first time.
# Starts the timer for despawning.
func _ready():
	$Despawn.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Despawns if the boss is dead.
func _process(_delta):
	if global.boss_hp <= 0:
		queue_free()

# Despawns the lightning.
func _on_despawn_timeout():
	queue_free()

# Does 3 damage to the player
func _on_area_entered(area):
		if area.has_meta("Player"):
			global.hp -= DAMAGE
