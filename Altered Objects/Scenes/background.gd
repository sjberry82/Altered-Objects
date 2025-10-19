extends Node2D

func _process(delta):
	translate(Vector2.LEFT * 30 * delta) #background speed

func _on_end_of_level_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file.call_deferred("res://Scenes/world2.tscn")
