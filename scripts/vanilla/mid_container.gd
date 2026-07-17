extends VBoxContainer

func _ready() -> void:
	var window = get_window()
	window.size_changed.connect(_on_window_size_changed)
	_on_window_size_changed()

func _on_window_size_changed():
	self.custom_maximum_size = Vector2(get_window().size.x * 0.58,get_window().size.y)
