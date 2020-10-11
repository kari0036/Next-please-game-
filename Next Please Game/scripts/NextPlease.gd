extends StaticBody2D

onready var sprite = $Sprite

func press():
	sprite.frame = 1
	get_tree().call_group("NPC", "nextPlease")
	
func unpress():
	sprite.frame = 0
