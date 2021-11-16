extends Node

# Behaviour for letting a unit follow its target
# Requires the parent to provide a target as variable!

onready var parent = get_parent()

func _process(delta):
	if parent.currentlyAttacking:
		return
	if parent.currentTarget == null:
		return
	var movxy = (parent.currentTarget.position-parent.position).normalized()*delta*parent.movementSpeed
	parent.move_and_collide(movxy)
