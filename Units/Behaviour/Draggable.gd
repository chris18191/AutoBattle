tool
extends Area2D

export (float, 1,200) var radius = 10 setget updateRadius

var lifted = false

func updateRadius(x):
	radius = x
	$DragArea.shape.set_radius(radius)

func _unhandled_input(event):
	if not Settings.draggingAllowed:
		return
	if event is InputEventMouseButton and not event.pressed:
		lifted = false
	if lifted and event is InputEventMouseMotion:
		get_parent().position += event.relative * Settings.cameraZoom

func _input_event(viewport, event, shape_idx):
	if not Settings.draggingAllowed:
		return
	if event is InputEventMouseButton and event.pressed:
		lifted = true
