extends Label

@onready var parent_node = self.get_parent()

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	if GlobalFunc._check_if_character_stage():
		var now_san = GlobalVar.module_temp_data["character"][GlobalVar.in_game_data["select_one"]]["detail"]["san"]
		var max_san = GlobalVar.module_temp_data["character"][GlobalVar.in_game_data["select_one"]]["detail"]["max_san"]
		self.text = str(int(now_san)) + "/" + str(int(max_san))
		parent_node.get_parent().get_node("San").text = GlobalVar.module_temp_data["variable"]["normal"]["status"]["san"][GlobalSys.system_lang_zone]
		parent_node.max_value = max_san
		parent_node.value = now_san
