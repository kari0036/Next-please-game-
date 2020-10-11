extends KinematicBody2D

var comming
var velocity = Vector2()
var target = Vector2(141,123)

func nextPlease():
	if !comming:
		comming = true

func _physics_process(delta):
	if comming:
		velocity = position.direction_to(target) * 100
		if position.distance_to(target) > 5:
			velocity = move_and_slide(velocity)
