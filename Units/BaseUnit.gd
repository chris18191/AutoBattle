tool
extends Targetable

signal took_damage

onready var _attackTimer = $AttackTimer
onready var _viewShape = $View/Shape
onready var _attackShape = $AttackRadius/Shape

var _arena

export (int) var movementSpeed = 0
export (int) var maxHealth = 0
var currentHealth
export (int) var attackDamage = 0
export (float) var attackSpeed = 1.0 # in attacks/s
export (float, 10,500) var viewDistance = 50 setget _updateViewDistance
export (float, 10,500) var attackRadius = 50 setget _updateAttackRadius
export (PackedScene) var projectile = null
export (int) var projectileSpawnRadius = 10

var currentTarget: Targetable = null
var currentlyAttacking: bool = false

var possibleTargets = []

########## TOOL FUNCTIONS

func _updateViewDistance(x):
	viewDistance = x
	if has_node("View/Shape"):
		$View/Shape.shape.set_radius(viewDistance)

func _updateAttackRadius(x):
	attackRadius = x
	if has_node("AttackRadius/Shape"):
		$AttackRadius/Shape.shape.set_radius(attackRadius)

########## GAME LOGIC

func _ready():
	$View/Shape.shape.set_radius(viewDistance)
	$AttackRadius/Shape.shape.set_radius(attackRadius)
	_arena = get_parent()
	currentHealth = maxHealth
	Helpers.set_unit_collision(faction, self)
	

func _on_View_body_entered(body):
	if currentTarget == body:
		return
	print("seeing body:" + str(body) + " with faction="+str(body.faction))
	if body.faction == faction:
		return
	if isEnemy(body):
		if currentTarget == null:
			currentTarget = body
		else:
			if not body in possibleTargets:
				possibleTargets.append(body)

func _on_AttackRadius_body_entered(body):
	if isEnemy(body):
		if currentTarget == null:
			currentTarget = body
		elif not currentTarget == body:
			possibleTargets.append(currentTarget)
		if not currentlyAttacking:
			startAttacking()

func isEnemy(x):
	return x != null and faction != x.faction and x is Targetable

func startAttacking():
	currentlyAttacking = true
	
	_attackTimer.wait_time = 1.0/attackSpeed
	_attackTimer.start()
	
	print("attacking: " + str(currentTarget))

func stopAttacking():
	currentlyAttacking = false
	_attackTimer.stop()
	print("stopped attacking: " + str(currentTarget))

func receiveDamage(dmg:float):
	currentHealth -= dmg
	if currentHealth > 0:
		emit_signal("took_damage")
	else:
		die()

func die():
	print_debug("I am dead")
	queue_free()

func _on_AttackRadius_body_exited2(body):
	currentTarget = null
	if len(possibleTargets) == 0:
		stopAttacking()
		return
	currentTarget = possibleTargets.pop_front()
	var overlappingBodies = $AttackRadius.get_overlapping_bodies()
	if not currentTarget in overlappingBodies:
		stopAttacking()

func _on_AttackRadius_body_exited(body):
	if body != currentTarget:
		return
	var attackableTargets = $AttackRadius.get_overlapping_bodies()
	if len(attackableTargets) == 0:
		stopAttacking()
		return
		
	currentTarget = attackableTargets.pop_front()
	while not isEnemy(currentTarget):
		currentTarget = possibleTargets.pop_front()
	if currentTarget == null:
		stopAttacking()


func _on_View_body_exited(body):
	print("body exited view")
	if body == currentTarget:
		if len(possibleTargets) > 0:
			currentTarget = possibleTargets.pop_front()
			while not isEnemy(currentTarget) and len(possibleTargets) > 0:
				currentTarget = possibleTargets.pop_front()
			if not $AttackRadius.overlaps_body(currentTarget):
				stopAttacking()
		else:
			currentTarget = null
	elif body in possibleTargets:
		possibleTargets.erase(body)


func _on_AttackTimer_timeout():
	# deal damage to target by firing projectile
	if projectile == null or currentTarget == null:
		return
	var proj = projectile.instance()
	var attackDir = (currentTarget.position - position).normalized()
	proj.init(position + attackDir*projectileSpawnRadius, currentTarget, attackDir, faction)
	_arena.add_child(proj)
