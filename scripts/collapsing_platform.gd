extends StaticBody2D

# Variables for collapse timing
var timer = 0.0 # Tracks time player has been on platform
var is_player_on = false # True when player is standing on it
const COLLAPSE_TIME = 1.0 # Seconds before platform disappears

func _physics_process(delta):
	if is_player_on:
		timer += delta # Count time while player is on
		if timer >= COLLAPSE_TIME:
			queue_free() # Remove platform after 2 seconds

# Player steps on platform
func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		is_player_on = true
		timer = 0.0 # Reset timer when player lands

# Player steps off platform
func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		is_player_on = false
		timer = 0.0 # Reset timer when player leaves
		print("Player off collapsing platform")  # Debug to confirm exit