extends Node2D

var dragging

func _unhandled_input(event):
	if not Settings.draggingAllowed:
		return
	if event is InputEventMouseButton and event.pressed:
		dragging = true
	if event is InputEventMouseButton and not event.pressed:
		dragging = false
	if dragging and event is InputEventMouseMotion:
		Settings.camera.drag_camera(-event.relative)
