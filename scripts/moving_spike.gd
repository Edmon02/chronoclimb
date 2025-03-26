extends PathFollow2D

# Movement variables
var speed = 150.0 # Speed in pixels per second
var direction = 1 # 1 for forward, -1 for backward
var path_length = 0.0 # Total length of the Path2D, calculated in _ready

# Signal to notify level of player collision
signal player_touched

func _ready():
	# Get the total length of the Path2D curve
	path_length = get_parent().curve.get_baked_length()
	
	# Check if MovingSpike node exists before connecting signal
	var moving_spike = $MovingSpike
	if moving_spike:
		moving_spike.connect("body_entered", _on_detection_area_body_entered)
	else:
		print("Error: 'MovingSpike' node not found! Check scene structure.")

func _physics_process(delta):
	# Move along the path
	var new_progress = get_progress() + (speed * delta * direction)
	set_progress(new_progress)
	
	# Reverse direction when reaching the ends of the path
	if new_progress >= path_length or new_progress <= 0.0:
		direction *= -1

# Called when the player enters the spike's Area2D
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_touched") # Trigger respawn in the level script
