class_name AudioManager extends Node

var fx:AudioStreamOggVorbis
var colletion_Streamplayer:Array[AudioStreamPlayer];
var max_streamplayer:int = 10;
func _create_streamPlayer(cantidad:int = 3) -> void:
	for i in cantidad:
		var node = AudioStreamPlayer.new()
		self.add_child(node)
		colletion_Streamplayer.append(node);
func _get_or_create_streamPlayer() -> AudioStreamPlayer:
	for i in range(colletion_Streamplayer.size()):
		var stream_player:AudioStreamPlayer = colletion_Streamplayer.pop_front();
		colletion_Streamplayer.push_back(stream_player);
		if !stream_player.playing:
			#colletion_Streamplayer.push_back(stream_player);
			return stream_player;
	if colletion_Streamplayer.size() < max_streamplayer:
		var new_streamplayer = AudioStreamPlayer.new();
		colletion_Streamplayer.push_back(new_streamplayer);
		return new_streamplayer;
	return null;
func _ready() -> void:
	_create_streamPlayer(4);
func play(stream:AudioStream, volumen:float, pitch:float) -> void:
	var current_streamPlayer:AudioStreamPlayer = _get_or_create_streamPlayer();
	#if current_streamPlayer.playing:
		
		#for i in colletion_Streamplayer:
			#current_streamPlayer = i;
			#if i.playing:
				#current_streamPlayer = null
				#continue
			#break
		#if !current_streamPlayer:
			#var new_streamplayer = AudioStreamPlayer.new();
			#colletion_Streamplayer.append(new_streamplayer);
			#current_streamPlayer = new_streamplayer;
	current_streamPlayer.stream = stream;
	current_streamPlayer.volume_db = volumen;
	current_streamPlayer.pitch_scale = pitch;
	current_streamPlayer.autoplay
	current_streamPlayer.play();
