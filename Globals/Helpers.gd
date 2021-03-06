extends Node


func set_unit_collision(faction: int, body:KinematicBody2D):
	body.set_collision_layer_bit(faction, true)#
	for i in range(Settings.MAX_FACTION_NUM):
		body.set_collision_mask_bit(i, true)


func set_projectile_collision(faction: int, body:KinematicBody2D):
	for i in range(Settings.MAX_FACTION_NUM):
		# set collision mask to all other factions but the own
		body.set_collision_mask_bit(i, i!=faction)

func get_map_position_of_event(event:InputEventMouseButton):
	print_debug("Global position: ", event.global_position)
	return Settings.camera.get_canvas_transform().affine_inverse().xform(event.position)
