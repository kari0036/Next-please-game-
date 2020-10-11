extends Control




func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Gabinet_Lekarski.tscn")
	pass 


func _on_Button2_pressed():
	get_tree().quit()
	pass 
