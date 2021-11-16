extends "res://Units/Projectiles/Projectile.gd"

func _process(_delta):
	_on_Projectile_collision(self.target)
