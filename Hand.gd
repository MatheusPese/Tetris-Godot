extends Node2D

onready var game = get_tree().get_root().get_node( "Game" )
onready var row:int = self.position.y / game.GRID_SIZE_IN_PIXELS.y

onready var shapes = ["res://Shapes/I-shape.tscn",
					 "res://Shapes/J-shape.tscn",
					 "res://Shapes/L-shape.tscn",
					 "res://Shapes/O-shape.tscn",
					 "res://Shapes/S-shape.tscn",
					 "res://Shapes/T-shape.tscn",
					 "res://Shapes/Z-shape.tscn"]

func _ready():
	randomize()
	add_shape_in_hand()
	
	
func add_shape_in_hand():
	if get_child_count() == 0:
		var  s = load(shapes[randi() % shapes.size()])
		var shape = s.instance()
		self.add_child(shape)
		pass
	else:
		push_error("Error, do not add in a the hand when there is already a pice")
		
func _input(event):
	if event is InputEventKey:
		_rotate_shape_action()
		_move_shape_horizontal_action()
		_move_shape_vertical_action()	
		
func _rotate_shape_action():
	if Input.is_action_just_pressed("ui_up"):
		self.rotation_degrees += 90
		
func _move_shape_horizontal_action():
	update_screen_block_array()
	var LEFT = _shape_move_left()
	var RIGHT = _shape_move_right()

	self.position += Vector2( ( RIGHT - LEFT ) * game.GRID_SIZE_IN_PIXELS.x, 0 )


func _shape_move_left():
	var LEFT:int = 0

	for i in get_child(0).get_children():
		print("L", int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x)+1, " | ", game.column)
		if int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x) == 0:
			return 0
	LEFT = int( Input.is_action_just_pressed( "ui_left" ) )
	return LEFT

func _shape_move_right():
	var RIGHT:int = 0

	for i in get_child(0).get_children():
		print("R", int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x)+1, " | ", game.column)
		if int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x)+1 == game.column:
			return 0
		
	RIGHT = int( Input.is_action_just_pressed( "ui_right" ) )
	return RIGHT


func _move_shape_vertical_action():
	if Input.is_action_just_pressed( "ui_down" ):	
		_shape_move_down()

func _shape_move_down():
	update_screen_block_array()
	for i in get_child(0).get_children():
		if  int(i.global_position.y / game.GRID_SIZE_IN_PIXELS.y)+1 == game.row:
			return
		
	self.position.y += game.GRID_SIZE_IN_PIXELS.y
		
func update_screen_block_array():
	game.screen_block_array = game.create_2d_array(game.column, game.row, 0)
	for i in get_child(0).shape_blocks_positions:
		if i.x < game.column && i.x > 0:
			game.screen_block_array[int(i.y)][int(i.x)] = 1