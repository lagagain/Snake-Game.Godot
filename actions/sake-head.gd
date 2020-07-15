extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {LEFT, RIGHT, UP, DOWN, NO}
var speed = 2
var gap = -70
var direction_move_map = {
		LEFT: Vector2(-speed, 0),
		RIGHT: Vector2(speed, 0),
		UP: Vector2(0, -speed),
		DOWN: Vector2(0, speed),
		NO: Vector2(0,0),
	}
var rotation_degrees_map = {
		LEFT: 180,
		RIGHT: 0,
		UP: -90,
		DOWN: 90,
		NO: 0,
	}
var direction = NO
onready var body = preload("res://scenes/snake-body.tscn")
onready var bodys = [get_node("tail")]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("tail").dir_arr = [NO]
	get_node("tail").dir_arr_time = [gap/speed]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	var head = get_node("head")
	if Input.is_action_just_pressed("ui_up"):
		move_up()
	elif Input.is_action_just_pressed("ui_down"):
		move_down()
	elif Input.is_action_just_pressed("ui_left"):
		move_left()
	elif Input.is_action_just_pressed("ui_right"):
		move_right()
	move_snake()

func move_snake():
	var head = get_node("head")
	head.position += direction_move_map[direction]*speed
	head.rotation_degrees = rotation_degrees_map[direction]
	var next_dir = direction
	for b in bodys:
		var dir = b.dir_arr[0]
		b.position += direction_move_map[dir]*speed
		b.rotation_degrees = rotation_degrees_map[dir]
		b.dir_arr_time[0] += speed
		if b.dir_arr_time[0] >= 0:
			b.dir_arr_time.pop_front()
			b.dir_arr.pop_front()
		b.dir_arr.push_back(direction)
		b.dir_arr_time.push_back(speed)
		
func move_up():
	direction = UP
func move_down():
	direction = DOWN
func move_left():
	direction = LEFT
func move_right():
	direction = RIGHT

	
func add_body():
	var tail = get_node("tail")
	var new_body = body.instance()
	new_body.position = tail.position
	tail.position += Vector2(gap, 0)
	new_body.dir_arr = tail.dir_arr.duplicate()
	new_body.dir_arr_time = tail.dir_arr_time.duplicate()
	tail.dir_arr.push_front(RIGHT)
	tail.dir_arr_time.push_front(gap/speed)
	bodys.append(new_body)
	add_child(new_body)

