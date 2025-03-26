extends Area2D

signal player_touched  # Emitted when player touches hazard

func _on_Hazard_body_entered(body):
    if body.is_in_group("Player"):
        emit_signal("player_touched")  # Tell level to reset player

# func _on_body_entered(body:Node2D) -> void:
# 	pass # Replace with function body.
