extends PlayerState


func enter() -> void:
	#player.playback.travel(AnimationName.IDLE);
	pass
	
func physics_process(delta: float) -> void:
	fricc_move(delta*player.stats_terrain.fricc_move)
	if player.is_fall:
		state_machine.travel_to(StateName.FALL);
func unhandled_input(event: InputEvent) -> void:
	if player.try_move:
		state_machine.travel_to(StateName.RUN);
	if player.try_jump:
		state_machine.travel_to(StateName.JUMP);
