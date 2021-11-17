extends Camera2D

var dragging = false

func _ready():
	Settings.cameraZoom = zoom
	if current:
		Settings.camera = self

func _set(property, value):
	if property == "zoom":
		zoom = value
		Settings.cameraZoom = zoom

func _input(event):
	if Input.is_action_just_released("ZoomIn"):
		self.zoom -= Settings.ZOOM_SPEED
	if Input.is_action_just_released("ZoomOut"):
		self.zoom += Settings.ZOOM_SPEED
	if Input.is_action_pressed("MoveCameraUp"):
		drag_camera(Settings.CAMERA_MOVE_SPEED_UP)
	if Input.is_action_pressed("MoveCameraDown"):
		drag_camera(Settings.CAMERA_MOVE_SPEED_DOWN)
		
func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		dragging = false
	if not Settings.draggingAllowed or Settings.unit_currently_lifted:
		return
	if event is InputEventMouseButton and event.pressed:
		dragging = true

	if dragging and event is InputEventMouseMotion:
		position += -event.relative * Settings.cameraZoom

func drag_camera(direction):
	position += direction*Settings.cameraZoom #-event.relative * Settings.cameraZoom
