tool
extends Node2D

export (Vector2) var cell_size = Vector2(32,32) setget _set_cellsize

func _set_cellsize(x):
	cell_size = x
	if has_node("Map"):
		$Map/TileMap.scale = cell_size / $Map/TileMap.cell_size
	if has_node("PlayerContainer"):
		$PlayerContainer.position = cell_size/2

func _ready():
	print_debug("cell size: " + str(cell_size))
	_set_cellsize(cell_size)
	pass

func _process(_delta):
	if Input.is_action_just_released("ui_up"):
		$PlayerContainer.position.y -= cell_size.y
		print_pos()
	if Input.is_action_just_released("ui_down"):
		$PlayerContainer.position.y += cell_size.y
		print_pos()
	if Input.is_action_just_released("ui_left"):
		$PlayerContainer.position.x -= cell_size.x
		print_pos()
	if Input.is_action_just_released("ui_right"):
		$PlayerContainer.position.x += cell_size.x
		print_pos()

func print_pos():
	print_debug("Player container currently at tile: " + str(($PlayerContainer.position/cell_size).floor()))
