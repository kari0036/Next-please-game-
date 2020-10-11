extends Area2D


enum STATE{
	IDLE,
	GRAB
}

onready var sprite = $sprite


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

var carried_item
func grab_state():
	if (!carried_item):
		var items = get_overlapping_areas()
		if items:
			carried_item = items[0]
	else:
		carried_item.position = position
	
	
	sprite.frame = 1
func idle_state():
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
