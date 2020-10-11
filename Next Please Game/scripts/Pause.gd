extends Control


func _input(event):
	if event.is_action_pressed("pause"):
		var PauseState = not get_tree().paused
		get_tree().paused = PauseState
		visible = PauseState


func _on_Button_pressed():
	get_tree().quit()
	pass 
