extends Node2D

func _ready():
    # Connect button signals programmatically (or use editor)
    $PlayButton.connect("pressed", _on_play_pressed)
    $SettingsButton.connect("pressed", _on_settings_pressed)

func _on_play_pressed():
    # Start the game by loading Level 1
    get_tree().change_scene_to_file("res://scenes/Level1.tscn")

func _on_settings_pressed():
    # Placeholder for settings (print for now, expand later)
    print("Settings button pressed! Add settings scene here.")
    # Optionally, transition to a Settings.tscn scene if created
    # get_tree().change_scene_to_file("res://Settings.tscn")