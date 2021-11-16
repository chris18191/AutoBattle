extends Camera2D


func _ready():
	Settings.cameraZoom = zoom

func _set(property, value):
	
	zoom = x
	Settings.cameraZoom = zoom
