extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "ręka":
			if (Input.is_action_pressed("grab")):
				position = lerp(get_global_mouse_position(),position,0.6)
