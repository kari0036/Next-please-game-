extends StaticBody2D

onready var sprite = $Sprite

func press():
	sprite.frame = 1
	
func unpress():
	sprite.frame = 0
