extends CharacterBody2D

# Physics constants (all in pixels per second or seconds)
const GRAVITY = 1000.0 # Downward force; higher values mean faster falls
const JUMP_FORCE = -400.0 # Upward velocity on jump; negative because up is negative in 2D
const MOVE_SPEED = 200.0 # Max horizontal speed
const ACCELERATION = 2000.0 # How fast player speeds up horizontally
const DECELERATION = 2000.0 # How fast player slows down when stopping
const COYOTE_TIME = 0.1 # Seconds player can jump after leaving a platform
const JUMP_BUFFER_TIME = 0.1 # Seconds jump input is remembered before landing
const WALL_SLIDE_SPEED = 50.0 # Slow downward speed when sliding on a wall
const WALL_JUMP_FORCE = Vector2(300.0, -500.0) # Horizontal push (x) and upward force (y) for wall jump
const REWIND_TIME = 5.0 # Seconds to rewind
const PHYSICS_FPS = 60.0 # Assumed physics frames per second (default in Godot)
const REWIND_BUFFER_SIZE = int(REWIND_TIME * PHYSICS_FPS) # Total states stored (300 frames = 5s)

# State variables
var coyote_timer = 0.0 # Tracks time since leaving ground for coyote jumps
var jump_buffer_timer = 0.0 # Tracks time since jump was pressed for buffering
var is_sliding = false # True when player is sliding down a wall
var rewind_buffer = [] # Stores past positions and velocities

# Reference to the AnimatedSprite2D node
@onready var animated_sprite = $AnimatedSprite

func _physics_process(delta):
	var was_on_floor = is_on_floor() # Remember if player was grounded before moving

	# Horizontal movement with acceleration/deceleration
	var direction = Input.get_axis("move_left", "move_right") # -1 (left), 0, or 1 (right)
	if direction != 0:
		velocity.x += direction * ACCELERATION * delta # Gradually speed up
		velocity.x = clamp(velocity.x, -MOVE_SPEED, MOVE_SPEED) # Cap speed
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta) # Slow to a stop

	# Apply gravity every frame
	velocity.y += GRAVITY * delta

	# Jumping with coyote time and jump buffer
	if Input.is_action_just_pressed("jump"):
		if was_on_floor or coyote_timer > 0: # Jump if grounded or in coyote window
			velocity.y = JUMP_FORCE
			coyote_timer = 0 # Disable further coyote jumps
		else:
			jump_buffer_timer = JUMP_BUFFER_TIME # Buffer jump for when we land

	# Wall sliding: slow descent when against a wall and falling
	is_sliding = is_on_wall() and velocity.y > 0 and not is_on_floor()
	if is_sliding:
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED) # Cap fall speed

	# Wall jumping: push away from wall with an upward boost
	if is_sliding and Input.is_action_just_pressed("jump"):
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var normal = collision.get_normal() # Wall's normal vector (points away from wall)
			if abs(normal.x) > 0.9: # Ensure it's a vertical wall
				velocity = Vector2(-normal.x * WALL_JUMP_FORCE.x, WALL_JUMP_FORCE.y)
				break

	# Move the character using physics
	move_and_slide()

	# Check for landing to trigger buffered jump
	if not was_on_floor and is_on_floor():
		if jump_buffer_timer > 0:
			velocity.y = JUMP_FORCE # Jump immediately on landing
			jump_buffer_timer = 0

	# Update coyote and jump buffer timers
	if is_on_floor():
		coyote_timer = COYOTE_TIME # Reset when on ground
	else:
		coyote_timer -= delta # Count down in air

	jump_buffer_timer -= delta # Always decrease jump buffer

	# Rewind ability: reset to state from 5 seconds ago
	if Input.is_action_just_pressed("rewind") and rewind_buffer.size() > 0:
		var oldest_state = rewind_buffer[0] # Get state from 5s ago
		position = oldest_state["position"] # Reset position
		velocity = oldest_state["velocity"] # Reset velocity
		rewind_buffer.clear() # Clear buffer to prevent instant re-rewind

	# Store current state for rewinding
	rewind_buffer.append({"position": position, "velocity": velocity})
	if rewind_buffer.size() > REWIND_BUFFER_SIZE:
		rewind_buffer.remove_at(0) # Remove oldest state to keep buffer at 5s

	# Animation control
	if is_on_floor():
		if direction != 0:
			animated_sprite.play("walk") # Play walking animation when moving
			# Flip sprite based on direction
			animated_sprite.flip_h = direction < 0 # Flip left if moving left
		else:
			animated_sprite.stop() # Stop animation when idle
			# Optionally, you can add an "idle" animation here later

	# Store state for rewinding
	rewind_buffer.append({"position": position, "velocity": velocity})
	if rewind_buffer.size() > REWIND_BUFFER_SIZE:
		rewind_buffer.remove_at(0)
