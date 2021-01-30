extends Sprite

func _ready():
	# set up FMOD
	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	
	# load banks
	Fmod.load_bank("res://Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)

	# register listener
	Fmod.add_listener(0, self)

	# play some events
	Fmod.play_one_shot("event:/Coin", self)
