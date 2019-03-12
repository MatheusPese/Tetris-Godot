extends Node2D

onready var game = get_tree().get_root().get_node( "Game" )
onready var row:int = self.position.y / game.GRID_SIZE_IN_PIXELS.y

var side = 1

func _input(event):
	if event is InputEventKey:
		_rotate_shape_action()
		_move_shape_horizontal_action()
		_move_shape_vertical_action()	
		

func _rotate_shape_action():
	if Input.is_action_just_pressed("ui_up"):
		side = -side
		self.rotation_degrees += 90 * side

func _move_shape_horizontal_action():
	update_screen_block_array()
	
	var LEFT:int = int( Input.is_action_just_pressed( "ui_left" ) )
	var RIGHT:int  = int( Input.is_action_just_pressed( "ui_right" ) )

	self.position += Vector2( ( RIGHT - LEFT ) * game.GRID_SIZE_IN_PIXELS.x, 0 )

func _move_shape_vertical_action():
	if Input.is_action_just_pressed( "ui_down" ):	
		_shape_move_down()

func _shape_move_down():
	update_screen_block_array()
	row = self.position.y / game.GRID_SIZE_IN_PIXELS.y
	
	if  self.row + 1 != game.row:
		self.position.y += game.GRID_SIZE_IN_PIXELS.y
		
func update_screen_block_array():
	game.screen_block_array = game.create_2d_array(game.column, game.row, 0)
	for i in get_child(0).shape_blocks_positions:
		game.screen_block_array[i.y][i.x] = 1