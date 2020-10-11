extends Area2D


enum STATE{
	IDLE,
	GRAB
}

onready var sprite = $sprite

#global var
var CarriedItem
var CurrentState
var ButtonPresed
var SavedPositon = Vector2.ZERO
#global var

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func grab_state():
	if !CarriedItem:
		for body in  get_overlapping_bodies():
			if body.is_in_group("items"):
				CarriedItem = body
				SavedPositon = CarriedItem.position
				break
			if body.is_in_group("button"):
				if !ButtonPresed:
					body.press()
					ButtonPresed = true
					break
	else:
		CarriedItem.position = position
		
	
	sprite.frame = 1
	
func idle_state():
	var on_holder = false
	
	if CarriedItem:
		for body in get_overlapping_bodies():
				if body.is_in_group("item_holder"):
					on_holder = true
		if !on_holder:
			CarriedItem.position = SavedPositon
			
		CarriedItem = null
	sprite.frame = 0
	
func _physics_process(delta):
	
	position = lerp(get_global_mouse_position(),position,0.6)

	if (Input.is_action_pressed("grab")): 
		CurrentState = STATE.GRAB
	else: 
		CurrentState = STATE.IDLE
	
	match CurrentState:
		STATE.IDLE:
			get_tree().call_group("button", "unpress")
			ButtonPresed = false
			idle_state()
		STATE.GRAB:
			grab_state()
