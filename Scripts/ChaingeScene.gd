extends Control

func _ready():
	if not Fmod.started:
		Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
		Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
		
		# load banks
		Fmod.load_bank("res://Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		Fmod.load_bank("res://Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		
	for button in $VBoxContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.sceneToLoad])
	
	Fmod.add_listener(0, self)

	# play some events
	Fmod.play_one_shot("event:/Music/TitleScreen", self)
	
func _on_Button_pressed(sceneToLoad):
	Fmod.stop_all_bus_events("bus:/", Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	get_tree().change_scene_to(sceneToLoad)
