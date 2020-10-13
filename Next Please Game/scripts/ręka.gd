extends Area2D


enum STATE{
	IDLE,
	GRAB
}

onready var sprite = $sprite

#global var
var carried_item
var CurrentState
var ButtonPresed
var saved_position = Vector2.ZERO
#global var

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func grab_state():
	if !carried_item:
		for body in  get_overlapping_bodies():
			if body.is_in_group("items"):
				carried_item = body
				saved_position = carried_item.position
				break
			if body.is_in_group("button"):
				if !ButtonPresed:
					body.press()
					ButtonPresed = true
					break
	else:
		carried_item.position = position
		
	
	sprite.frame = 1
	
func idle_state():
	var on_holder = false
	
	if carried_item:
		for body in get_overlapping_bodies():
				if body.is_in_group("item_holder"):
					on_holder = true
				if body.is_in_group("NPC"):
					body.get_item(carried_item)
		if !on_holder:
			carried_item.position = saved_position
			
		carried_item = null
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
