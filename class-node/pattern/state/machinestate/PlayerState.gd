class_name PlayerState extends State

var player:Jugador:
	get():
		return node_controller;
var game:Game:
	get():
		return get_tree().root.get_node("Game")
func accel_move(deltatime:float) -> void:
	player.velocity.x = move_toward(player.velocity.x,player.SPEED* player.axis.x, deltatime)
	#player.velocity.x = move_toward(player.velocity.x,player.axis.x * player.stats_value.Speed,player.stats_value.accel_speed * delta)

func fricc_move(deltatime) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, deltatime)
	#player.position = move_toward(player.position.x,player.SPEED)
	#player.velocity.x = move_toward(player.velocity.x,player.axis.x * player.stats_value.Speed,player.stats_value.accel_speed * delta)
func fricc_move_y(deltatime) -> void:
	player.velocity.y = move_toward(player.velocity.y, 0, deltatime+500)
