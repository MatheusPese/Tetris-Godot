extends Node2D

onready var game = get_tree().get_root().get_node( "Game" )

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
	

func _input(event):
	if event is InputEventKey:
		_rotate_shape_action()
		_move_shape_horizontal_action()
		_move_shape_vertical_action()	
			
	
func add_shape_in_hand():
	var s
	var shape

	if get_child_count() == 0:
		var next_shape = str(shapes[randi() % shapes.size()])
		s = load( next_shape )
		shape = s.instance()
		self.add_child( shape )
	else:
		push_error("Error, do not add in a the hand when there is already a pice")
		

func _rotate_shape_action():
	if Input.is_action_just_pressed("ui_up"):
		self.rotation_degrees += 90
		update_screen_block_array()
		
func _move_shape_horizontal_action():
	update_screen_block_array()
	var LEFT = _shape_move_left()
	var RIGHT = _shape_move_right()

	self.position += Vector2( ( RIGHT - LEFT ) * game.GRID_SIZE_IN_PIXELS.x, 0 )


func _shape_move_left():
	var LEFT:int = 0
	if get_child(0) != null:
		for i in get_child(0).get_children():
			if int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x + 0.5) == 0:
				return 0
	LEFT = int( Input.is_action_just_pressed( "ui_left" ) )
	return LEFT


func _shape_move_right():
	var RIGHT:int = 0
	if get_child(0) != null:
		for i in get_child(0).get_children():
			if int(i.global_position.x / game.GRID_SIZE_IN_PIXELS.x)+1 == game.column:
				return 0
		
	RIGHT = int( Input.is_action_just_pressed( "ui_right" ) )
	return RIGHT


func _move_shape_vertical_action():
	if Input.is_action_just_pressed( "ui_down" ):	
		_shape_move_down()


func _shape_move_down():
	var botton_row = game.row
	update_screen_block_array()
	if get_child(0) != null:
		for i in get_child(0).shape_blocks_positions:
			var one_block_position = i.y+.5
			print(one_block_position)
			if  one_block_position == botton_row:
				place_shape()
				return 0
						
	self.position.y += game.GRID_SIZE_IN_PIXELS.y

	
func update_screen_block_array():
	game.screen_block_array = game.create_2d_array(game.column, game.row, 0)
	if get_child(0) != null:
		for i in get_child(0).shape_blocks_positions:
			if i.x < game.column && i.x > 0:
				game.screen_block_array[int(i.y)][int(i.x)] = 1

func place_shape():
	var shape = get_child(0)
	var shape_position = shape.global_position
	var shape_rotation = shape.global_rotation
	remove_child(shape)
	shape.global_position = shape_position
	shape.global_rotation = shape_rotation
	get_parent().add_child(shape)
	
	self.position = Vector2(8,8)
	add_shape_in_hand()