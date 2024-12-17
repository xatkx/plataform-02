extends PlayerState
@export var time:float = 0.2
@export var fricc_mov:float = 400.0
const POST_JUMP_4 = preload("res://assets/sonido/wav/Post Jump 4.wav");
func enter() -> void:
	FxManager.play(POST_JUMP_4,1,2.0);
	player.playback.travel(AnimationName.GROUNDED);
	await get_tree().create_timer(time).timeout
	state_machine.travel_to(StateName.IDLE);
func physics_process(delta: float) -> void:
	fricc_move(delta*fricc_mov)
	
