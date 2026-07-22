extends Label

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	if GlobalVar.module_temp_data["character"].has("player"):
		self.text = GlobalVar.module_temp_data["character"]["player"]["info"]["nickname"][GlobalSys.system_lang_zone]
