extends Control

func _ready():
	for button in $VBoxContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.sceneToLoad])
		
func _on_Button_pressed(sceneToLoad):
	get_tree().change_scene(sceneToLoad)
