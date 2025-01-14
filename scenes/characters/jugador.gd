class_name  Jugador extends CharacterBody2D


var flip = 1;
var portal_obj:PortalData;
var gravity_enable:bool = true;
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

func _ready() -> void:
	animation_tree = $Animation/AnimationTree;
	playback = animation_tree.get("parameters/playback");

	portal_obj = PortalData.new();

func _physics_process(delta: float) -> void:

	move_and_slide();
	flip_sprite();
	if gravity_enable:
		gravity(delta)
	put_terrain();
func _input(event: InputEvent) -> void:
	#axis = Input.get_vector("left","right","up","down");
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
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
