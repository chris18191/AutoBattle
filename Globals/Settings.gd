extends Node

const ZOOM_SPEED = Vector2(.1, .1)
const MAX_FACTION_NUM = 4

const CAMERA_MOVE_SPEED_UP = Vector2(0,-50)
const CAMERA_MOVE_SPEED_DOWN = -CAMERA_MOVE_SPEED_UP

var draggingAllowed = true
var cameraZoom = Vector2(1.0,1.0)
var camera : Camera2D = null

var unit_currently_lifted = false
