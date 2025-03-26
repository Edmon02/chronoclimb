extends CharacterBody2D

var speed = 100.0  # Speed in pixels per second
var direction = 1  # 1 for right, -1 for left
const GRAVITY = 1000.0  # Same gravity as player for consistency

func _physics_process(delta):
    # Apply gravity
    velocity.y += GRAVITY * delta
    
    # Move horizontally
    velocity.x = speed * direction
    
    # Check for cliffs or walls to turn around
    var ground_check = $GroundCheck
    if not ground_check.is_colliding() or is_on_wall():
        direction *= -1  # Reverse direction
    
    # Move and slide
    move_and_slide()

# Trigger respawn if player touches enemy
func _on_area_entered(area):
    if area.is_in_group("Player"):
        emit_signal("player_touched")