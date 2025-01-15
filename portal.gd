class_name Portal extends Node2D

signal used_portal

@export var portalData = PortalData.new();
var enable:bool= false
func respawn(player):
	player.position = self.position - Vector2(0,-20)

func _unhandled_input(event: InputEvent) -> void:
	if self.enable and portalData.is_active and Input.is_action_just_pressed("action_1"):
		if LevelManager.Manager.get_current_lv().name != self.portalData.Destiny:
			LevelManager.Manager.travel_to(self.portalData.Destiny);
		else :
			LevelManager.Manager.change_lv.emit();
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Jugador:
		body.portal_obj = portalData;
		self.enable = true;

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body as Jugador:
		self.enable = false;
