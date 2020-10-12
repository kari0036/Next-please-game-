extends KinematicBody2D

var velocity = Vector2()
var room = Vector2(141,123)
var outOfRoom = Vector2(400,123)

var heMove = false
var firstPatient = true
var goToRoom = false

onready var suit = $suit
onready var head = $head
var maxsuit = 2
var maxhead = 4

func nextPlease():
	if !heMove:
		heMove = true
			
func _physics_process(delta):
	if heMove && firstPatient:
		goTo(room)
	else: if heMove:
		changePatient()
	
func goTo(target):
	velocity = position.direction_to(target) * 100
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	else:
		heMove = false
		firstPatient = false
		
		
func changePatient():
	if !goToRoom:
		velocity = position.direction_to(outOfRoom) * 100
		if position.distance_to(outOfRoom) > 5:
			velocity = move_and_slide(velocity)
		else: 
			suit.frame = randi()%maxsuit
			head.frame = randi()%maxhead
			goToRoom = true
	else:
		velocity = position.direction_to(room) * 100
		if position.distance_to(room) > 5:
			velocity = move_and_slide(velocity)
		else:
			goToRoom = false
			heMove = false
	
