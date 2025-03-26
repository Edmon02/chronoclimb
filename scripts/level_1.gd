extends Node2D

# References to key nodes
@onready var player = $Player
@onready var spawn_point = $SpawnPoint.position # Player's starting position
@onready var door = $Door
@onready var ui_label = $CanvasLayer/Label

var crystals_collected = 0 # Tracks collected Time Crystals

func _ready():
	# Connect all hazard signals
	for hazard in get_tree().get_nodes_in_group("Hazards"):
		hazard.connect("player_touched", _on_hazard_touched)
	# Connect Time Crystal signal
	$TimeCrystal.connect("collected", _on_time_crystal_collected)
	# Initialize UI
	update_ui()

# Reset player to spawn point when hazard is touched
func _on_hazard_touched():
	player.position = spawn_point
	player.velocity = Vector2.ZERO # Reset velocity to avoid carrying momentum

# Handle Time Crystal collection
func _on_time_crystal_collected():
	crystals_collected += 1
	update_ui()
	door.queue_free() # Remove door to open the way

func update_ui():
	ui_label.text = "Crystals: %d" % crystals_collected

func _on_viewport_size_changed():
	var viewport_size = get_viewport_rect().size
	var base_size = Vector2(1280, 720)  # Your base resolution
	var scale_factor = min(viewport_size.x / base_size.x, viewport_size.y / base_size.y)
	
	# Scale all sprites (optional, adjust as needed)
	for node in get_tree().get_nodes_in_group("Sprites"):
		if node is Sprite2D:
			node.scale = Vector2(scale_factor, scale_factor)

func _on_time_crystal_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
