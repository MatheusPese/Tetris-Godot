extends Node2D

onready var Game = get_tree().get_root().get_node("Game")

func _input(event):
	var LEFT = int(Input.is_action_just_pressed("ui_left"))
	var RIGHT = int(Input.is_action_just_pressed("ui_right"))
	
	
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_up"):
			self.rotation_degrees += 90
		self.position += Vector2( (RIGHT-LEFT) * Game.GRID_SIZE_IN_PIXELS.x,0)
		
		if Input.is_action_just_pressed("ui_down"):
			self.position.y += Game.GRID_SIZE_IN_PIXELS.y




func _shape_move_down():
	self.position.y += Game.GRID_SIZE_IN_PIXELS.y