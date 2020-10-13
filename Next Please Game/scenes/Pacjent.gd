extends StaticBody2D

const TARGETX = 141
const SPAWNPOS = Vector2(320,120)
const MAXSUIT = 2
const MAXHEAD = 4
const SMOOTH = 0.1

onready var suit = $suit
onready var head = $head
onready var collisionshape = $CollisionShape2D

enum STATE{
	BEGIN,
	GO_IN,
	GO_OUT,
	IN,
	OUT
}
var current_state
var inventory = []


func next_please():
	collisionshape.disabled = true
	match current_state:
		STATE.IN: current_state = STATE.GO_OUT
		STATE.BEGIN: current_state = STATE.OUT



func go_in(): 
	if position.x - TARGETX > 1:
		position.x = lerp(position.x, TARGETX, 0.1)
	else: 
		collisionshape.disabled = false
		current_state = STATE.IN 

func go_out(): 
	if SPAWNPOS.x - position.x > 1:
		position.x = lerp(position.x, SPAWNPOS.x, 0.1)
	else: 
		current_state = STATE.OUT
	
func when_out():
	randLooks()
	inventory = []
	current_state = STATE.GO_IN


func randLooks():
	suit.frame = rand_range(0,MAXSUIT)
	head.frame = rand_range(0, MAXHEAD)



func get_item(item):
	inventory.append(item.name)
	item.queue_free()




func _ready():
	position = SPAWNPOS
	current_state = STATE.BEGIN


func _physics_process(delta):
	match current_state:
		STATE.GO_IN:
			go_in()
		STATE.GO_OUT:
			go_out()
		STATE.OUT:
			when_out()
	print(inventory)
