extends KinematicBody2D

class_name Projectile

export (float) var damage = 1
export (float) var movementSpeed = 100

var direction = Vector2(0,0)
var faction = 0
var target:Targetable = null

func init(pos:Vector2, target: Targetable, attackDir, fac=0, damage_mult=1.0, speed_mult=1.0):
	damage *= damage_mult
	movementSpeed *= speed_mult
	self.position = pos
	self.target = target
	direction = attackDir
	faction = fac
	Helpers.set_projectile_collision(faction, self)

func _ready():
	pass

func _process(delta):
	var collision = move_and_collide(delta*movementSpeed*direction)
	if collision != null:
		_on_Projectile_collision(collision.collider)

func _on_Projectile_collision(body:Targetable):
	if body == null:
		return
	if (body.faction != faction):
		body.receiveDamage(damage)
		print_debug("BOOM")
		queue_free()
	
