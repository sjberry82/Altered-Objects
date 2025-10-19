extends Area2D
var speed = 200

func _process(delta):
	translate(Vector2.LEFT * speed * delta)
