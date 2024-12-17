class_name StateMachine extends Node

@export var holder = self.owner;
@export var default_state:State;
@export var history_state_max:int = 10;
var history_state:Array[String]; # crea un history lista con los 10 o 20 ultimos state

var current_state:State = null:
	set(value):
		_history_state_update(value.name);
		current_state = value;
	get():
		return current_state;


@export_group("debugg")
@export var debugg:bool = false
@export var debugg_history: bool = false;

# inticialzar
func _debuggmsg(mensage:String) -> void:
	printerr(mensage);
	print_stack();
	print_tree();
	print_debug()
	print_verbose();
func _initializar() -> void:
	_transition_to(default_state);
# function que update all variable
func _transition_to(state:State) -> void:
	if !state:
		_debuggmsg("the state is null");
		return
	if debugg:
		prints(self.name,"enter in the state",state.name);
		if debugg_history:
			print(history_state)
	
	if current_state : current_state.exit();
	
	current_state = state;
	current_state.state_machine = self;
	current_state.node_controller = holder;
	current_state.enter();

func _history_state_update(text:String) -> void:
	if !text.is_empty() and history_state.size() >= history_state_max:
		history_state.remove_at(history_state_max-1);
	history_state.push_back(name)

func _ready() -> void:
	await get_tree().process_frame
	_initializar();

# funcion que cambie de estados
func travel_to(new_state:String) -> void:
	var state:State = self.get_node_or_null(new_state);
	_transition_to(state);

#region procces and inputs -,.,-
func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("physics_process"):
		current_state.physics_process(delta);
func _process(delta: float) -> void:
	if current_state and current_state.has_method("process"):
		current_state.process(delta);
func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("unhandled_input"):
		current_state.unhandled_input(event)
func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("unhandled_key_input"):
		current_state.unhandled_key_input(event)
#endregion
