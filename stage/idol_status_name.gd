extends Label

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var t_name = GlobalVar.in_game_data["select_one"]
	self.text = GlobalVar.module_temp_data["character"][t_name]["info"]["name"][GlobalSys.system_lang_zone]
