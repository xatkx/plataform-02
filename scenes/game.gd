#lk

class_name Game extends Node2D

var player:Jugador;
var audio_fx_colletion:Dictionary

func _ready() -> void:
	player = self.get_node("Jugador");
	audio_fx_colletion = Get_Resources.get_all_dir_resources("res://assets/sonido/ogg/","",".ogg")
func _on_level_manager_change_lv(lv: Level) -> void:
	
	var portals = get_tree().get_nodes_in_group("portal");
	for portal:Portal in portals:
		if portal.portalData.Id_portal == player.portal_obj.go_to_portal:
			portal.respawn(player)
