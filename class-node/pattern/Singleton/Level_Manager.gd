class_name LevelManager extends Node2D

signal change_lv(level:Level)

@export_dir var path:= "";
@export var default_lv:PackedScene
var current_lv:Level = null;
#reguion singleton
static var Manager:LevelManager = null;
static func get_manager() -> LevelManager:
	if Manager:
		return Manager;
	return LevelManager.new();
func _init() -> void:
	Manager = self;
#end
func _get_Lv_packed(path, key:String) -> PackedScene:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				#file_name = file_name.to_lower();
				key = key.to_lower();
				if file_name.begins_with(key) and file_name.ends_with(".tscn"):
					return load(path+"/"+file_name);

			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return null;
func _get_lv_by_name(lv_name:String) -> Level:
	return _get_Lv_packed(path,lv_name).instantiate();
func _transition(new_lv:Level) -> void:
	if self.get_child_count() > 0:
		for i in self.get_children():
			i.queue_free();

	await get_tree().process_frame
	self.add_child(new_lv);
	current_lv = new_lv;
	change_lv.emit(new_lv);
func _init_default():
	if !default_lv:
#debuugg zZ
		return
	var lv = default_lv.instantiate();
	_transition(lv)
func _ready() -> void:
	await get_tree().process_frame
	_init_default()
	pass
func travel_to(new_lv:String) -> void:
	var lv = _get_lv_by_name(new_lv);
	_transition(lv);
func get_current_lv() -> Level:
	return current_lv;
