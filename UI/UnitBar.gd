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
		if node_name == "AnimatedSprite":
			for node_prop_idx in state.get_node_property_count(node_idx):
				var node_prop_name = state.get_node_property_name(node_idx, node_prop_idx)
				if node_prop_name == "frames":
					var prop_value:SpriteFrames = state.get_node_property_value(node_idx, node_prop_idx)
					itemList.add_item(state.get_node_name(0), prop_value.get_frame("default", 0))

func _unhandled_input(event):
	if not Settings.draggingAllowed:
		return
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			spawn_currentSelection(event, 0)	
		if event.button_index == BUTTON_RIGHT:
			spawn_currentSelection(event, 1)
		
func _input_event(viewport, event, shape_idx):
	if not Settings.draggingAllowed:
		return
	if event is InputEventMouseButton and event.pressed:
		print_debug("Received click in UnitBar")

func spawn_currentSelection(event : InputEventMouseButton, faction : int):
	var selection = itemList.get_selected_items()
	if len(selection) == 0:
		return
	selection = selection[0]
	selection = units[selection]
	var pos = Helpers.get_map_position_of_event(event)
	print_debug("spawning element: ", selection, " at: ", pos, " with faction: ", faction)
	var new_unit = selection.instance()
	new_unit.faction = faction
	get_parent().get_parent().get_node("World").add_child(new_unit)
	new_unit.position = pos

