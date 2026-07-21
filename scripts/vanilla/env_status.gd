extends RichTextLabel

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

# 显示节点只能拿取外部数据
func native_update_data():
	var season = GlobalVar.in_game_data["season"]
	match season:
		1:
			season = GlobalVar.module_temp_data["variable"]["system"]["seasons"]["season_one"][GlobalSys.system_lang_zone]
		2:
			season = GlobalVar.module_temp_data["variable"]["system"]["seasons"]["season_two"][GlobalSys.system_lang_zone]
		3:
			season = GlobalVar.module_temp_data["variable"]["system"]["seasons"]["season_three"][GlobalSys.system_lang_zone]
		4:
			season = GlobalVar.module_temp_data["variable"]["system"]["seasons"]["season_four"][GlobalSys.system_lang_zone]
	var weekend = GlobalVar.in_game_data["week_count"]
	match weekend:
		1:
			weekend = GlobalVar.module_temp_data["variable"]["system"]["weekends"]["weekend_one"][GlobalSys.system_lang_zone]
		2:
			weekend = GlobalVar.module_temp_data["variable"]["system"]["weekends"]["weekend_two"][GlobalSys.system_lang_zone]
		3:
			weekend = GlobalVar.module_temp_data["variable"]["system"]["weekends"]["weekend_three"][GlobalSys.system_lang_zone]
		4:
			weekend = GlobalVar.module_temp_data["variable"]["system"]["weekends"]["weekend_four"][GlobalSys.system_lang_zone]
	var day = GlobalVar.in_game_data["day_count"]
	match day:
		1:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_one"][GlobalSys.system_lang_zone]
		2:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_two"][GlobalSys.system_lang_zone]
		3:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_three"][GlobalSys.system_lang_zone]
		4:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_four"][GlobalSys.system_lang_zone]
		5:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_five"][GlobalSys.system_lang_zone]
		6:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_six"][GlobalSys.system_lang_zone]
		7:
			day = GlobalVar.module_temp_data["variable"]["system"]["days"]["day_seven"][GlobalSys.system_lang_zone]
	# 转换时段
	var time_of_day = GlobalVar.in_game_data["time_h"]
	var index = GlobalVar.module_temp_data["variable"]["system"]["time_of_day"].keys()
	for i in index:
		var t_condition = GlobalVar.module_temp_data["variable"]["system"]["time_of_day"][i]["condition"]
		if t_condition[0] >= 0 && t_condition[-1] < t_condition[0]:
			if time_of_day < t_condition[-1] or time_of_day >= t_condition[0]:
				time_of_day = GlobalVar.module_temp_data["variable"]["system"]["time_of_day"][i][GlobalSys.system_lang_zone]
				GlobalVar.in_game_data["time_mark"] = i
				break
		else:
			if time_of_day >= t_condition[0] && time_of_day < t_condition[-1]:
				time_of_day = GlobalVar.module_temp_data["variable"]["system"]["time_of_day"][i][GlobalSys.system_lang_zone]
				GlobalVar.in_game_data["time_mark"] = i
				break
	var t_h = GlobalVar.in_game_data["time_h"]
	var t_m = GlobalVar.in_game_data["time_m"]
	var t_time:String
	if t_h < 10:
		if t_m < 10:
			t_time = "0" + str(t_h) + ":0" + str(t_m)
		else:
			t_time = "0" + str(t_h) + ":" + str(t_m)
	else:
		if t_m < 10:
			t_time = str(t_h) + ":0" + str(t_m)
		else:
			t_time = str(t_h) + str(t_m)
	var weather = GlobalVar.in_game_data["weather"]
	weather = GlobalVar.module_temp_data["variable"]["system"]["weathers"][weather][GlobalSys.system_lang_zone]
	var temperature = str(GlobalVar.in_game_data["temperature"])
	self.text = season + "  " + weekend + "  " + day + "(" + time_of_day + ")" + "  " + t_time + "  " + weather + "  " + temperature + "°"
