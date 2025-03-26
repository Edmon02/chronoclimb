extends Node2D

# Reference to the label for animation
@onready var sponsor_label = $SponsorLabel
@onready var transition_timer = $TransitionTimer # Reference to the timer

func _ready():
	# Center the label based on viewport size
	center_label()
	
	# Start the retro animation: scale up and down
	var tween = create_tween()
	tween.tween_property(sponsor_label, "scale", Vector2(1.2, 1.2), 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sponsor_label, "scale", Vector2(1.0, 1.0), 0.5).set_trans(Tween.TRANS_SINE)
	tween.set_loops() # Loop the animation indefinitely
	
	# Ensure timer is running (optional, should autostart if set in editor)
	transition_timer.start()

func _process(_delta):
	# Skip to landing page with any key press
	if Input.is_anything_pressed():
		transition_to_landing()

func _on_transition_timer_timeout() -> void:
	# Transition after timer ends
	transition_to_landing()

func transition_to_landing():
	# Change scene to LandingPage
	get_tree().change_scene_to_file("res://scenes/LandingPage.tscn")

func center_label():
	# Get the viewport size
	var viewport_size = get_viewport_rect().size
	
	# Get the label's size (rect_size gives the bounding box of the text)
	var label_size = sponsor_label.get_rect().size
	
	# Calculate centered position
	# Position = (viewport center) - (half of label size)
	var centered_position = Vector2(
		(viewport_size.x - label_size.x) / 2,
		(viewport_size.y - label_size.y) / 2
	)
	
	# Apply the position to the label
	sponsor_label.position = centered_position
