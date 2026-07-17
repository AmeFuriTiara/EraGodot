extends Node

func _ready() -> void:
	GlobalSignal.connect("_require_event_content",Callable(self,"_match_event"))

func check_module():
	# 检查模组文件夹是否存在
	var folder_name = "modules"
	var dir = DirAccess.open("user://")
	if dir.dir_exists(folder_name):
		print_debug("检测到模组文件夹 '", folder_name, "' 存在")
	else:
		dir.make_dir(folder_name)
		print_debug("没有检测到模组文件夹，已重新创建")
		return {}
	# 检查模组是否存在
	var results:Dictionary = {}
	var folder_names = DirAccess.get_directories_at("user://modules")
	if folder_names.size() == 0:
		GlobalSignal.emit_signal("_no_module_found")
		return {}
	for t_name in folder_names:
		print_debug("发现模组：" + t_name)
		var cfg = "user://modules/" + t_name + "/module_cfg.json"
		# 读取配置文件里的基本数据 加载并返回
		if dir.file_exists(cfg):
			print_debug("检测到" + t_name + "配置文件")
			var temp = FileAccess.open(cfg,FileAccess.READ)
			var text = temp.get_as_text()
			var data = JSON.parse_string(text)
			temp.close()
			results[t_name] = data
			print_debug("模组数据可用")
		else:
			print_debug("模组" + t_name + "配置文件不存在")
	return results

func _load_module(m_name:String):
	# 检查模组文件夹是否存在
	var dir = DirAccess.open("user://modules")
	print_debug("正在尝试载入模组......")
	var cfg = "user://modules/" + m_name + "/module_cfg.json"
	if dir.file_exists(cfg):
		print_debug("配置文件存在")
		var temp = FileAccess.open(cfg,FileAccess.READ)
		var text = temp.get_as_text()
		var data = JSON.parse_string(text)
		temp.close()
		if data["module_name"] == m_name:
			print_debug("验证已匹配")
			GlobalVar.now_module_name = m_name
			GlobalVar.module_native_path = "user://modules/" + m_name + "/"
			GlobalVar.module_cfg = data
			GlobalVar.module_relate_path = data["module_relate_path"]
			print_debug("配置文件已加载")
			# 加载模组内容到缓存
			# 加载自定义变量
			var variable_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["variable"]
			if dir.file_exists(variable_folder_path):
				_get_and_set(variable_folder_path, "variable")
			print_debug("变量导入完成")
			var personality_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["personality"]
			if dir.file_exists(personality_folder_path):
				_get_and_set(personality_folder_path, "personality")
			print_debug("性格导入完成")
			var stage_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["stage"]
			if dir.file_exists(stage_folder_path):
				_get_and_set(stage_folder_path, "stage")
			print_debug("场景导入完成")
			# 初始化角色索引
			var character_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["character"]
			if dir.dir_exists(character_folder_path):
				var file_list = DirAccess.open(character_folder_path).get_files()
				if file_list.size() > 0:
					for i in file_list:
						var ipath = character_folder_path + "/" + i
						var str = str(i).trim_suffix(".json")
						GlobalVar.character_json_path[str] = ipath
						_get_and_set(ipath, "character")
			print_debug("角色索引建立完成")
			# 初始化调色盘
			var colortable_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["colortable"]
			if dir.file_exists(colortable_folder_path):
				_get_and_set(colortable_folder_path, "colortable")
			print_debug("色盘导入完成")
			# 初始化事件索引
			# 只有事件需要判明本地化
			var event_folder_path = GlobalVar.module_native_path + GlobalVar.module_relate_path["event"]
			if dir.dir_exists(event_folder_path):
				var file_list = DirAccess.open(event_folder_path).get_files()
				if file_list.size() > 0:
					for i in file_list:
						var ipath = event_folder_path + "/" + i
						GlobalVar.event_json_path[i] = ipath
						_get_and_set(ipath, "event")
			print_debug("事件索引建立完成")
		else:
			print_debug("验证不匹配")
			return
	else:
		print_debug("配置文件不存在")
		return
	GlobalSignal.emit_signal("_init_load_done")

func _get_and_set(path:String,target_block:String):
	var temp = FileAccess.open(path,FileAccess.READ)
	var text = temp.get_as_text()
	var data = JSON.parse_string(text)
	match target_block:
		"variable":
			GlobalVar.module_temp_data["variable"] = data
		"personality":
			GlobalVar.module_temp_data["personality"] = data
		"stage":
			GlobalVar.module_temp_data["stage"] = data
		"character":
			#data["detail"] = {}
			GlobalVar.module_temp_data["character"][data["info"]["sid"]] = data
		"colortable":
			GlobalVar.module_temp_data["colortable"] = data
		"event":
			GlobalVar.module_temp_data["event"][data["info"]["sid"]] = data["info"]
			if GlobalVar.module_temp_data["event"].has("events") == false:
				GlobalVar.module_temp_data["event"]["events"] = {}
			var arr = data["events"].keys()
			for i in arr:
				GlobalVar.module_temp_data["event"]["events"][i] = {}
	temp.close()

# 比对索引返回数据
func _match_event(id:String):
	var arr = GlobalVar.module_temp_data["event"]["events"].keys()
	if arr.has(id):
		var list = GlobalVar.event_json_path.keys()
		for key in list:
			var temp = FileAccess.open(GlobalVar.event_json_path[key],FileAccess.READ)
			var text = temp.get_as_text()
			var data = JSON.parse_string(text)
			temp.close()
			var t_list = data["events"].keys()
			if t_list.has(id):
				GlobalVar.playing_data = data["events"][id]
	# 用去除法算事件的角色触发条件
	var character_count = GlobalVar.playing_data["character"]
	for i in GlobalVar.character_on_stage:
		if character_count.has(i):
			character_count.erase(i)
	if character_count.size() == 0:
		# 复杂条件判断区域
		var condition = GlobalVar.playing_data["condition"]
		if condition.size() != 0:
			if GlobalVar.character_json_path.keys().has(condition[0]):
				if GlobalVar.module_temp_data["character"].keys().has(condition[0]):
					if condition.size() == 5:
						match condition[3]:
							"LE":
								pass
							"E":
								pass
							"GE":
								if GlobalVar.module_temp_data["character"][condition[0]]["detail"][condition[1]][condition[2]] >= condition[4]:
									pass
								else:
									return
			if GlobalVar.character_ping == condition[0]:
				var playing_array = GlobalVar.playing_data["text"]["ping"]
				playing_array.reverse()
				GlobalSignal.emit_signal("_return_event_content", playing_array)
		else:
			var playing_array = GlobalVar.playing_data["text"]["normal"]
			playing_array.reverse()
			GlobalSignal.emit_signal("_return_event_content", playing_array)
		
func _get_sprite_path(any:Array):
	var pre_path = "user://modules/" + GlobalVar.now_module_name
	match any[0]:
		"character":
			var back_path = GlobalVar.module_cfg["module_relate_path"]["character_sprites"]
			var fix_path = pre_path + "/" + back_path + "/" + any[1] + "/" + any[2]
			if DirAccess.dir_exists_absolute(fix_path):
				var file_path = fix_path + "/" + any[1] + "_" + any[2] + ".png"
				if FileAccess.file_exists(file_path):
					return file_path
		"event":
			var back_path = GlobalVar.module_cfg["module_relate_path"]["event_sprites"]
			var fix_path = pre_path + "/" + back_path
			return fix_path
		"banner":
			var back_path = GlobalVar.module_cfg["module_relate_path"]["banner_sprites"]
			var fix_path = pre_path + "/" + back_path
			return fix_path
