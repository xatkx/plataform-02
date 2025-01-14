extends PlayerState
var timer:Timer = Timer.new();
const ATTACK_SWING = preload("res://assets/sonido/ogg/AttackSwing.ogg");
@export var max_dash:= 500;
@export var dash_fricc:= 3000;
var before_gravity:int = 0
func _end_dash(delta:float) -> void:
	#player.stats_terrain.gravity = before_gravity;
	#player.velocity.y += player.stats_terrain.gravity * delta
	player.velocity.x = 0
	player.gravity_enable = true;
	if !player.is_on_floor():
		state_machine.travel_to(StateName.FALL);
	if !player.try_move:
		state_machine.travel_to(StateName.IDLE);
	if player.try_move:
		state_machine.travel_to(StateName.RUN);
func should_end_dash(value:float) -> bool:
	return abs(player.velocity.x) < value;
func enter():

# configurar el estado inicial
	player.smoth.emitting = true
	player.smoth.direction.x = player.axis.x
	FxManager.play(ATTACK_SWING,5,2.0);
	player.playback.travel(AnimationName.DASH)
	#configurar el estado inicial del dash y desabilitar gravedad
	player.velocity.x = player.axis.x * player.SPEED + player.axis.x * max_dash
	#before_gravity = player.stats_terrain.gravity;
	#player.stats_terrain.gravity = 0
	player.gravity_enable = false;
#aplicar mov inicial
	player.move_and_slide();
	
func physics_process(delta: float) -> void:

	var friccion:int = dash_fricc * delta if player.is_on_floor() else dash_fricc * delta;
	fricc_move(friccion)
	fricc_move_y(friccion);
	if should_end_dash(10):
		#print("hola")
		_end_dash(delta);
		#pass
	else: 
		player.move_and_slide();
func exit():
	player.smoth.emitting = false;
