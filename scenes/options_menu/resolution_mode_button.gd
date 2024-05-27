extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DICT: Dictionary = {
	"1152 x 648": Vector2i(1152, 648),
	"1280 x 720": Vector2i(1280, 720),
	"1920 x 1080": Vector2i(1920, 1080)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	load_data()
	
func add_resolution_items():
	for resolution in RESOLUTION_DICT:
		option_button.add_item(resolution)

func on_resolution_selected(index: int):
	SettingsSignalBus.emit_on_resolution_selected(index)
	DisplayServer.window_set_size(RESOLUTION_DICT.values()[index])

func load_data():
	on_resolution_selected(SettingsDataContainer.get_resolution_index())
	option_button.select((SettingsDataContainer.get_resolution_index()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
