extends RichTextLabel

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	var select = GlobalVar.in_game_data["select_one"]
	var key = GlobalVar.module_temp_data["character"][select]["info"]["self_talk"].keys()
	var key_size = key.size()
	if key_size == 0:
		self.text = ""
		return
	if key_size == 1:
		self.text = translate(GlobalVar.module_temp_data["character"][select]["info"]["self_talk"]["1"][GlobalSys.system_lang_zone])
		if GlobalVar.module_temp_data["colortable"].keys().has(select):
			self.text = "[color=" + GlobalVar.module_temp_data["colortable"][select] + "]" + self.text + "[/color]"
		return
	if key_size > 1:
		var result = key.pick_random()
		self.text = translate(GlobalVar.module_temp_data["character"][select]["info"]["self_talk"][str(result)][GlobalSys.system_lang_zone])
		if GlobalVar.module_temp_data["colortable"].keys().has(select):
			self.text = "[color=" + GlobalVar.module_temp_data["colortable"][select] + "]" + self.text + "[/color]"
		return

func translate(any:String):
	var regex = RegEx.new()
	regex.compile("\\{([^}]+)\\}")
	var results = regex.search_all(any)
	for t_match in results:
		var mark = t_match.get_string(1)
		if GlobalVar.module_temp_data["character"].has(mark):
			any = any.replace(t_match.get_string(0), GlobalVar.module_temp_data["character"][str(mark)]["info"]["nickname"][GlobalSys.system_lang_zone])
	return any
