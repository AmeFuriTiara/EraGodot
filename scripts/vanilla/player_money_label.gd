extends Label

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	if GlobalVar.in_game_data.has("player_money"):
		match GlobalSys.system_lang_zone:
			"en":
				pass
			"zh":
				self.text = "余额：" + str(GlobalVar.in_game_data["player_money"]) + "円"
			"jp":
				pass
