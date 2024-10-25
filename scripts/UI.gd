extends CanvasLayer

@onready var global = get_node("/root/global")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Sets the Health of the labels to the health variable.
func _process(_delta):
	$HP.text = ("HP:" + str(global.HP))
	$BossHP.text = ("Boss HP:" + str(global.BossHP))
