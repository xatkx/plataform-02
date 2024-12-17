extends RayCast2D

var player:Jugador = null;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player");
	print(player)



func side() -> void:
	if player.axis.x > 0:
		self.target_position.x = 25;
	elif  player.axis.x < 0:
		self.target_position.x = -25;

func _unhandled_input(event: InputEvent) -> void:
	side()
