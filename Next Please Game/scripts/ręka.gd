extends Area2D


enum STATE{
	IDLE,
	GRAB
}

onready var sprite = $sprite


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


var carried_item
var saved_pos = Vector2.ZERO

func grab_state():
	if !carried_item:
		for body in  get_overlapping_bodies():
			if body.is_in_group("items"):
				carried_item = body
				saved_pos = carried_item.position
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
		if !on_holder:
			carried_item.position = saved_pos
		carried_item = null
	sprite.frame = 0




var current_state
func _physics_process(delta):
	position = lerp(get_global_mouse_position(),position,0.6)

	if (Input.is_action_pressed("grab")): current_state = STATE.GRAB
	else: current_state = STATE.IDLE
	
	match current_state:
		STATE.IDLE:
			idle_state()
		STATE.GRAB:
			grab_state()
