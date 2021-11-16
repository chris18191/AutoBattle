extends Control

export (Array, PackedScene) var units = Array()
onready var itemList = $Panel/ItemList

func _ready():
	for unit in units:
		add_unit(unit)

func add_unit(unit:PackedScene):
	var state = unit.get_state()
	for node_idx in state.get_node_count():
		var node_name = state.get_node_name(node_idx)
		print("Child node: ", node_name)
		if node_name == "AnimatedSprite":
			for node_prop_idx in state.get_node_property_count(node_idx):
				var node_prop_name = state.get_node_property_name(node_idx, node_prop_idx)
				print ("  node_prop_name=", node_prop_name)
				if node_prop_name == "frames":
					var prop_value:SpriteFrames = state.get_node_property_value(node_idx, node_prop_idx)
					
					itemList.add_item(state.get_node_name(0), prop_value.get_frame("default", 0))
