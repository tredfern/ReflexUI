function reflexAudio(_component, _propName) {
	if(_component[$ _propName] != undefined) {
		REFLEXUI.audioHandler(_component[$ _propName]);		
	}
	
}

function reflexAudioDefault(_soundProp) {
	audio_play_sound(_soundProp.sound, 0, false, _soundProp.gain, 0, _soundProp.pitch);
}