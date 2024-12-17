class_name AudioManager extends Node

var current_streamPlayer:AudioStreamPlayer
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
	var streamPlayer:AudioStreamPlayer = _get_or_create_streamPlayer();
	#if streamPlayer.playing:
		
		#for i in colletion_Streamplayer:
			#streamPlayer = i;
			#if i.playing:
				#streamPlayer = null
				#continue
			#break
		#if !streamPlayer:
			#var new_streamplayer = AudioStreamPlayer.new();
			#colletion_Streamplayer.append(new_streamplayer);
			#streamPlayer = new_streamplayer;
	streamPlayer.stream = stream;
	streamPlayer.volume_db = volumen;
	streamPlayer.pitch_scale = pitch;
	streamPlayer.autoplay
	streamPlayer.play();
	current_streamPlayer = streamPlayer;
