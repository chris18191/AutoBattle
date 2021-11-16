extends Node2D

var parent:Targetable
onready var progressbar = $TextureProgress

func _ready():
	parent = get_parent()
	parent.connect("took_damage", self, "updateBar")
	progressbar.max_value = parent.maxHealth

func updateBar():
	progressbar.value = parent.currentHealth
