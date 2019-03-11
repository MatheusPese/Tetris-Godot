extends Node2D

const GRID_SIZE_IN_PIXELS = Vector2(16,16)
var column = 16
var row = 32

onready var GameSpeed : float = 1
onready var StepTimer = $StepTimer

func _ready():
	StepTimer.wait_time = 1.5 - (GameSpeed/10.0)
	StepTimer.start()
	
	OS.set_window_size(Vector2(GRID_SIZE_IN_PIXELS.x * column, GRID_SIZE_IN_PIXELS.y * row))

func _process(delta):
	StepTimer.wait_time = 1.5 - (GameSpeed/10.0)