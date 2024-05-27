class_name MainMenu
extends Control


@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/PlayButton as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/OptionsButton as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/ExitButton as Button
@onready var options_menu = $OptionsMenu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

func handle_connecting_signals():
	play_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_options_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)

func on_exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false

func on_start_pressed() -> void:
	pass
	
func on_exit_pressed() -> void:
	get_tree().quit()

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(false)
	options_menu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
