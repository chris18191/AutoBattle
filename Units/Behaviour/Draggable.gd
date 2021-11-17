tool
extends Area2D

export (float, 1,200) var radius = 10 setget updateRadius

var self_lifted = false

func updateRadius(x):
	radius = x
	$DragArea.shape.set_radius(radius)

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		Settings.unit_currently_lifted = false
		self_lifted = false
	if Settings.unit_currently_lifted and self_lifted and event is InputEventMouseMotion:
		get_parent().position += event.relative * Settings.cameraZoom

func _input_event(viewport, event, shape_idx):
	if not Settings.draggingAllowed:
		return
	if not Settings.unit_currently_lifted and event is InputEventMouseButton and event.pressed:
		Settings.unit_currently_lifted = true
		self_lifted = true

