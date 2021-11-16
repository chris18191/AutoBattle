extends Camera2D


func _ready():
	Settings.cameraZoom = zoom

func _set(property, value):
	if property == "zoom":
		zoom = value
		Settings.cameraZoom = zoom

func _process(delta):
	if Input.is_action_just_released("ZoomIn"):
		print_debug("Zooming in")
		self.zoom -= Settings.ZOOM_SPEED
	if Input.is_action_just_released("ZoomOut"):
		print_debug("Zooming in")
		self.zoom += Settings.ZOOM_SPEED
