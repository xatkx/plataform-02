extends PlayerState


const PRE_JUMP_7 = preload("res://assets/sonido/wav/Pre Jump 7.wav")
func enter() -> void:

	FxManager.play(PRE_JUMP_7,-15.0,1.8);

	node_controller = node_controller as Jugador;
	#node_controller.playback.travel(AnimationName.JUMP);
	node_controller.velocity.y = player.JUMP_VELOCITY;
	node_controller.move_and_slide();

func physics_process(delta: float) -> void:
	var acceleration = delta * player.stats_terrain.accel_fly_move;
	var friccion = delta * player.stats_terrain.fricc_fly_move;
	if player.try_move:
		accel_move(acceleration)
	else:
		fricc_move(friccion)
		
	if player.velocity.y > 0:
		state_machine.travel_to(StateName.FALL);
	if player.try_dash:
		state_machine.travel_to(StateName.DASH)
#func unhandled_input(event: InputEvent) -> void:
	#if player.try_dash:
		#state_machine.travel_to(StateName.DASH)
