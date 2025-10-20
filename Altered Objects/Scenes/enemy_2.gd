extends Area2D

var speed = 300

const EXPLOSION = preload("res://Scenes/explosion.tscn")
const POWERUP = preload("res://Scenes/powerup.tscn")

func _process(delta):
	translate(Vector2.LEFT * speed * delta)
	#position.y += sin(position.x * delta) * .6 #sinwave movement
	
func _on_area_entered(area):
	if area.is_in_group("Projectile"):
		area.queue_free()
		explode()
		
func explode():
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	add_sibling.call_deferred(explosion)
	queue_free()
	
	if randi_range(0,6) == 0:
		var powerup = POWERUP.instantiate()
		powerup.global_position = global_position
		add_sibling.call_deferred(powerup)
