extends AnimatedSprite2D

func _ready():
	$Explosion.play()
	await animation_finished
	queue_free()
