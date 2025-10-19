extends CharacterBody2D
@export var health = 4
@export var speed = 400
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

var screensize = Vector2(640, 320)
var can_shoot = true
const PROJECTILE = preload("res://Scenes/projectile.tscn")

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health
	$Music.play()
	
func _process(_delta):
	var move = Input.get_vector("left","right","up","down")
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			shoot()
			$Timer.start(.25) #shooting speed
			can_shoot = false
		
func shoot():
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.global_position = $Marker2D.global_position
		add_sibling(new_projectile)
		$Shoot.play()
		
func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		health -= 1
		$Hurt.play()
		area.explode()
		progress_bar.value = health
		if health <= 0:
			get_tree().change_scene_to_file.call_deferred("res://Scenes/game_over.tscn")
			
	if area.is_in_group("HealthUp"):
		health += 1
		$PickUp.play()
		area.queue_free()
		if health > progress_bar.max_value: #keeps health from going above max value
			health = progress_bar.max_value
		progress_bar.value = health
		
func _on_timer_timeout():
	$Timer.stop()
	can_shoot = true
	
