extends Label



func putfps(fps:float) -> void:
	self.text = "FPS: " + str(fps);
	
func _process(delta: float) -> void:
	var frame = Engine.get_frames_per_second();

	putfps(frame);
