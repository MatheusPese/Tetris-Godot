extends Node2D

const GRID_SIZE_IN_PIXELS = Vector2(16,16)

var row : int = 32
var column : int = 16

onready var screen_block_array : Array = create_2d_array(column, row, 0)

onready var GameSpeed : float = 1
onready var StepTimer = $StepTimer

func _ready():
	StepTimer.wait_time = 1.5 - (GameSpeed/10.0)
	StepTimer.start()
	
	OS.set_window_size(Vector2(GRID_SIZE_IN_PIXELS.x * column, GRID_SIZE_IN_PIXELS.y * row))

func _process(delta):
	StepTimer.wait_time = 1.5 - (GameSpeed/10.0)





func create_2d_array(width, height, value) -> Array:
	var a = []

	for y in range(height):
		a.append([])
		a[y].resize(width)

		for x in range(width):
			a[y][x] = value

	return a