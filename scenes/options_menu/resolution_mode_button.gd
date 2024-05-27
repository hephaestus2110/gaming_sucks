extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DICT: Dictionary = {
	"1152 x 648": Vector2i(1152, 648),
	"1280 x 720": Vector2i(1280, 720),
	"1920 x 1080": Vector2i(1920, 1080)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	add_resoltuion_items()
	option_button.item_selected.connect(on_resolution_selected)
	
func add_resoltuion_items():
	for resolution in RESOLUTION_DICT:
		option_button.add_item(resolution)

func on_resolution_selected(index: int):
	DisplayServer.window_set_size(RESOLUTION_DICT.values()[index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
