extends PathFollow2D

# Movement variables
var speed = 50.0 # Speed in pixels per second
var direction = 1 # 1 for forward, -1 for backward
var total_length = 0.0 # Length of the path

# Reference to the player when on the platform
var player = null

func _ready():
	# Start at the beginning of the path
	set_progress(0.0)
	# Calculate the total length of the path
	total_length = get_parent().curve.get_baked_length()

func _physics_process(delta):
	# Get the current progress before moving
	var current_progress = get_progress()
	
	# Calculate the previous global position of the platform
	var previous_position = global_position
	
	# Update progress along the path
	current_progress += speed * delta * direction
	
	# Clamp progress and reverse direction at the ends
	if current_progress >= total_length:
		current_progress = total_length
		direction = -1
	elif current_progress <= 0:
		current_progress = 0
		direction = 1
	
	# Apply the updated progress
	set_progress(current_progress)
	
	# Calculate how much the platform moved this frame
	var movement = global_position - previous_position
	
	# Move the player if they're on the platform and grounded
	if player and player.is_on_floor():
		player.global_position += movement
	else:
		player = null # Clear reference if player isn't grounded or leaves

# Signal handlers for DetectionArea
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
