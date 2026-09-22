extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -400

var direction = 0

enum STATE {
	IDLE,
	RUN,
	JUMP,
	FALL
}

var cur_state = STATE.IDLE




func _physics_process(delta: float) -> void:
	
	gravedad(delta)
	direction = get_direction()
	print(cur_state)
	
	match cur_state:
		STATE.IDLE:
			state_idle(delta)
		STATE.RUN:
			state_run(delta)
		STATE.JUMP:
			state_jump(delta)
		STATE.FALL:
			state_fall(delta)
	

	move_and_slide()

func get_direction():
	return Input.get_axis("LEFT","RIGHT")

func gravedad(delta):
	velocity.y += get_gravity().y * delta

func switch_state(state):
		
	cur_state = state
	
	match state:
		STATE.JUMP:
			velocity.y = JUMP_VELOCITY
		
	pass
	

func state_idle(delta):
	$AnimatedSprite2D.play("idle")
	
	if not is_on_floor():
		switch_state(STATE.FALL)
	if direction != 0:
		switch_state(STATE.RUN)
	if is_on_floor() and Input.is_action_just_pressed("JUMP"):
		switch_state(STATE.JUMP)
	
	pass

func state_fall(delta):
	$AnimatedSprite2D.play("jump")
	
	velocity.x = direction * SPEED
	
	match direction:
		-1.0:
			$AnimatedSprite2D.flip_h = true
		1.0:
			$AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		switch_state(STATE.IDLE)
		
	
	

func state_run(delta):
	$AnimatedSprite2D.play("run")
	velocity.x = direction * SPEED
	
	match direction:
		0.0:
			switch_state(STATE.IDLE)
			
		-1.0:
			$AnimatedSprite2D.flip_h = true
		1.0:
			$AnimatedSprite2D.flip_h = false
			
	if not is_on_floor():
		switch_state(STATE.FALL)
	if is_on_floor() and Input.is_action_just_pressed("JUMP"):
		switch_state(STATE.JUMP)
		
	
	pass

func state_jump(delta):
	$AnimatedSprite2D.play("jump")
	velocity.x = direction * SPEED
	
	if velocity.y >= 0:
		switch_state(STATE.FALL)
		
	match direction:
		-1.0:
			$AnimatedSprite2D.flip_h = true
		1.0:
			$AnimatedSprite2D.flip_h = false
	
	
	pass
