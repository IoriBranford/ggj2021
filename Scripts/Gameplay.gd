extends Node2D

func _ready():
	# register listener
	Fmod.add_listener(0, self)

	# play some events
	Fmod.play_one_shot("event:/Music/Gameplay", self)
