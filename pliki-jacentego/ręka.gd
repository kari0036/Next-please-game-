extends KinematicBody2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum STATE{
	IDLE,
	GRAB
}

onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func grab_state():
	sprite.frame = 1
	
func idle_state():
	sprite.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.

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
