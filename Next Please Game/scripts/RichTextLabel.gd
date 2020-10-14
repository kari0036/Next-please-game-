extends RichTextLabel

onready var timer = $Timer

func write(dialog):
	if dialog == "end":
		text = ""
		visible_characters = 0
	else:
		dialog += "\n"
		text += dialog
		timer.start()

	
	
func _on_Timer_timeout():

	if text.length() != visible_characters:
			visible_characters += 1

