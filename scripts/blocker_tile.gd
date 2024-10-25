extends CharacterBody2D

var hp = 10
var health = hp : set = _set_health
@onready var health_bar = $Healthbar

# Called when the node enters the scene tree for the first time.
# Sets variables for health bars.
func _ready():
	health_bar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Updates the health bar visually. Also despawns the tile
func _process(delta):
	_set_health(health)
	if hp < 0 or hp == 0:
		queue_free()

# Updates the health visually.
func _set_health(value):
	if health_bar != null:
		health_bar.health = hp

# Takes damage when a player bullet is entered.
func _on_area_2d_area_entered(area):
	if area.has_meta("player"):
		hp -= 1

