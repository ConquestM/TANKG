extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Despawn.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if global.boss_hp <= 0:
		queue_free()


func _on_despawn_timeout():
	queue_free()


func _on_area_entered(area):
		if area.has_meta("Player"):
			global.hp -= 3
