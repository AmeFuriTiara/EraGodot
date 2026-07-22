extends HBoxContainer

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	if GlobalFunc._check_if_character_stage():
		self.visible = true
	else:
		self.visible = false
