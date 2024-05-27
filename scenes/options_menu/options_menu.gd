class_name OptionsMenu
extends Control

@onready var back_button = $MarginContainer/VBoxContainer/BackButton as Button

signal exit_options_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.button_down.connect(on_back_pressed)
	set_process(false)


func on_back_pressed():
	exit_options_menu.emit()
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dict())
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
