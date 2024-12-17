class_name Get_Resources extends Node

static func get_all_dir_resources(path:String ,start_key:String ,end_key:String ) -> Dictionary:
	var dir = DirAccess.open(path);
	var dic:Dictionary = {};
	if dir:
		dir.list_dir_begin();
		var file_name:String = dir.get_next();
		while file_name != "":
			if file_name.ends_with(end_key) and file_name.begins_with(start_key):
				var resource = load(path+"/"+file_name);
				var key_dic = file_name.replace(end_key,"").replace(start_key,"").to_lower();
				dic[key_dic] = resource;
			file_name = dir.get_next();
	return dic;
