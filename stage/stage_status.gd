extends RichTextLabel

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var t_stage = GlobalVar.in_game_data["now_location"]
	var s_text = GlobalVar.module_temp_data["stage"][t_stage[0]][GlobalSys.system_lang_zone]
	var d_text = GlobalVar.module_temp_data["stage"][t_stage[0]][t_stage[1]][GlobalSys.system_lang_zone]
	self.text = s_text + "  " + d_text + "  " + GlobalVar.in_game_data["description"]
