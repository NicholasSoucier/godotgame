extends CharacterBody2D

var PROJECTILE: PackedScene = preload("res://Scenes/pellet.tscn")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	movement()
	attack()
	move_and_slide()

func attack():
	var aimHor:=Input.get_axis("aim_left","aim_right")
	var aimVer:=Input.get_axis("aim_up","aim_down")
	
	if aimHor||aimVer:
		var pellet = PROJECTILE.instantiate()
		get_tree().current_scene.add_child(pellet)
		pellet.global_position = self.global_position
		var pDirection=Vector2(aimHor,aimVer)
		#print(Input.get_joy_axis(0,JOY_AXIS_LEFT_X))
		#print(Input.get_joy_axis(0,JOY_AXIS_LEFT_Y))
		pellet.rotation=pDirection.angle()
	elif Input.is_action_pressed("attack"):
		var pellet = PROJECTILE.instantiate()
		get_tree().current_scene.add_child(pellet)
		pellet.global_position = self.global_position
		var pDirection = self.global_position.direction_to(get_global_mouse_position()).angle()
		pellet.rotation=pDirection


func movement():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionHor := Input.get_axis("move_left", "move_right")
	var directionVer:=Input.get_axis("move_up","move_down")
	if directionHor||directionVer:
		velocity.x = directionHor * SPEED
		velocity.y= directionVer * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
