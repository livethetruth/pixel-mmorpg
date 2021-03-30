extends Control

func _ready():
	pass


func _on_Resume_pressed():
	get_node(".").hide()
	Globals.menu_shown = false

func _on_Change_Class_pressed():
	pass # Replace with function body.

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Exit_pressed():
	get_tree().quit()
