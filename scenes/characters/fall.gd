extends PlayerState

@onready var timeoffall: Timer = $timeoffall
var is_grounded:bool = false;
func enter() -> void:
	is_grounded = false
	timeoffall.start();
	player.playback.travel(AnimationName.FALL);
	
	
func physics_process(delta: float) -> void:
	if player.try_move:
		accel_move(delta*player.stats_terrain.accel_fly_move)
	else:
		fricc_move(delta*player.stats_terrain.fricc_fly_move)
		
	if is_grounded and player.is_on_floor():
		state_machine.travel_to(StateName.GROUNDED);
	elif !player.try_move and player.is_on_floor():
		state_machine.travel_to(StateName.IDLE);
	elif player.try_move and node_controller.is_on_floor():
		state_machine.travel_to(StateName.RUN);
	if player.try_dash:
			state_machine.travel_to(StateName.DASH)
#func unhandled_input(event: InputEvent) -> void:
	#if player.try_dash:
		#state_machine.travel_to(StateName.DASH);
		
func _on_timeoffall_timeout() -> void:
	is_grounded = true;
