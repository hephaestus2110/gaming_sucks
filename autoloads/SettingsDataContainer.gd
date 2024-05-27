extends Node

@onready var DEFAULT_SETTINGS: DefaultSettingsResource = preload("res://scenes/resources/settings/DefaultSettings.tres")

# Store all updates into these variables
var subtitles_state: bool = false
var windows_mode_index: int = 0
var resolution_index : int = 0
var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0
var loaded_data : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_signals()
	create_storage_dict()

func handle_signals():
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	SettingsSignalBus.on_subtitles_toggled.connect(on_subtitles_set)
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
	
func on_settings_data_loaded(data: Dictionary):
	loaded_data = data
	on_window_mode_selected(loaded_data.graphics_settings.window_mode_index)
	on_resolution_selected(loaded_data.graphics_settings.resolution_index)
	on_subtitles_set(loaded_data.accessibility_settings.subtitles_state)
	on_master_sound_set(loaded_data.sounds_settings.master_volume)
	on_music_sound_set(loaded_data.sounds_settings.music_volume)
	on_sfx_sound_set(loaded_data.sounds_settings.sfx_volume)

func create_storage_dict() -> Dictionary:
	var settings_container_dict: Dictionary = {
		"graphics_settings": {
			"window_mode_index" : windows_mode_index,
			"resolution_index" : resolution_index
		},
		"sounds_settings": {
			"master_volume" : master_volume,
			"music_volume" : music_volume,
			"sfx_volume" : sfx_volume
		},
		"accessibility_settings": {
			"subtitles_state" : subtitles_state,
		},
		"controls_setings": {
			"move_left" : InputMap.action_get_events("move_up"),
			"jump" : InputMap.action_get_events("jump")
		}
	}
	
	return settings_container_dict
	
func on_window_mode_selected(index: int):
	windows_mode_index = index
	
func on_resolution_selected(index: int):
	resolution_index = index
	
func on_subtitles_set(toggled: bool):
	subtitles_state = toggled
	
func on_master_sound_set(value: float):
	master_volume = value
	
func on_music_sound_set(value: float):
	music_volume = value
	
func on_sfx_sound_set(value: float):
	sfx_volume = value

func get_window_mode_index() -> int:
	if loaded_data == {}:
		# Default value
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return windows_mode_index

func get_resolution_index() -> int:
	if loaded_data == {}:
		# Default value
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index
	
func get_master_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume

func get_music_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume
	
func get_sfx_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume

func get_subtitles_state() -> bool:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SUBTITILES_SET
	return subtitles_state
	
