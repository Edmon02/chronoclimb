extends Area2D

# Signal emitted when the player collects the crystal
signal collected

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected") # Emit signal to notify the level
		queue_free() # Remove crystal from the scene
