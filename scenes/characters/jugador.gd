class_name  Jugador extends CharacterBody2D


var flip = 1;
var portal_obj:PortalData;
var gravity_enable:bool = true;
@export var statemachine:StateMachine = null;

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -450.0
@export var stats_terrain:StatsWorld;

@onready var timer_2_seg: Timer = $Timers/timer2seg
@onready var smoth: CPUParticles2D = $smoth
@onready var ray_cast_down: RayCast2D = $raycast/RayCast_down
@onready var ray_cast_front: RayCast2D = $raycast/RayCast_front

var animation_tree: AnimationTree;
var playback:AnimationNodeStateMachinePlayback;

var axis:Vector2;
var try_dash:bool:
	set(value):
		pass
	get():
		var enable:bool = false
		if try_move and Input.is_action_just_pressed("action_2") and timer_2_seg.is_stopped():
			enable = true
			timer_2_seg.start();
		return enable;
var try_move:bool:
	set(value):
		pass
	get():
		if axis.x != 0: #|| axis.y != 0:
			return true
		return false;
var try_jump:bool:
	set(value):
		pass
	get():
		return Input.is_action_just_pressed("up");
var is_fall:bool:
	set(value):
		pass
	get():
		return !self.is_on_floor();

var idle:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Idle";
		return false;
var dash:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Dash";
		return false;
var jump:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Jump";
		return false;
var fall:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Fall";
		return false;
var run:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Run";
		return false;
var grounded:bool:
	get():
		if statemachine.current_state:
			return statemachine.current_state.name == "Grounded";
		return false;


func _ready() -> void:
	animation_tree = $Animation/AnimationTree;
	playback = animation_tree.get("parameters/playback");

	portal_obj = PortalData.new();

func _physics_process(delta: float) -> void:
	animation_setting();
	#animation_setting_debugg()+++++
	move_and_slide();
	flip_sprite();
	if gravity_enable:
		gravity(delta)
	put_terrain();
	

func _input(event: InputEvent) -> void:
	#axis = Input.get_vector("left","right","up","down");
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

func animation_setting() -> void:
	animation_tree.set("parameters/conditions/Idle", idle);
	animation_tree.set("parameters/conditions/Run", run);
	animation_tree.set("parameters/conditions/Jump", jump);
	animation_tree.set("parameters/conditions/Fall", fall);
	animation_tree.set("parameters/conditions/Dash", dash);
	animation_tree.set("parameters/conditions/Grounded", grounded);
	
func animation_setting_debugg() -> void:
	print("idle", animation_tree.get("parameters/conditions/Idle"));
	print("run", animation_tree.get("parameters/conditions/Run"));
	print("jump", animation_tree.get("parameters/conditions/Jump"));
	print("fall", animation_tree.get("parameters/conditions/Fall"));
	print("dash", animation_tree.get("parameters/conditions/Dash"));
	print("grounded", animation_tree.get("parameters/conditions/Grounded"));

func flip_sprite() -> void:
	if axis.x > 0:
		flip = 1
	elif axis.x < 0:
		flip = -1;
	
	$Animation/Sprite.scale.x = flip
func gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += stats_terrain.gravity * delta;
func put_terrain() -> void:
	var terrain = ray_cast_down.get_collider();
	if terrain is Terrain:
		self.stats_terrain = terrain.stats_terrain;
