extends PlayerState
const FOOTSTEPS_CONCRETE_1 = preload("res://assets/sonido/steps/FootstepsConcrete1.ogg")

func runs():
	FxManager.play(FOOTSTEPS_CONCRETE_1,-4 ,3.5);
func run2():
	FxManager.play(FOOTSTEPS_CONCRETE_1,-4 ,3.5);

func enter() -> void:
	#player.playback.travel(AnimationName.RUN);
	pass

func process(delta: float) -> void:
	accel_move(delta*player.stats_terrain.accel_move);
	
func unhandled_input(event: InputEvent) -> void:
	if player.is_fall:
		state_machine.travel_to(StateName.FALL);
	if !player.try_move:
		state_machine.travel_to(StateName.IDLE)
	if player.try_jump:
		state_machine.travel_to(StateName.JUMP);
	if player.try_dash:
		state_machine.travel_to(StateName.DASH)
