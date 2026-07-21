extends RichTextLabel

@export var auto_play:bool = false

# 事件播放缓存
var playing_array:Array = []

var wait_for_choice:bool = false

# 事件选项数量度数
var choice_count:int = 1

func _ready():
	GlobalSignal.connect("_return_event_content",Callable(self,"get_event_content"))

# 按下超链接后重构文本+发出信号
func _on_meta_clicked(meta: Variant) -> void:
	while choice_count > 0:
		var last_paragraph_index = self.get_paragraph_count() - 1
		self.remove_paragraph(last_paragraph_index)
		choice_count -= 1
	var parts = str(meta).split("|")
	if parts.size() == 2:
		var id = str(parts[0])
		var display_text = parts[1]
		self.append_text("\n" + display_text)
		if id != "":
			require_event_content(id)
		self.append_text("\n")
		wait_for_choice = false

# 请求查询对应的事件文本
func require_event_content(id:String):
	GlobalSignal.emit_signal("_require_event_content",id)

# 接受返回的事件文本
func get_event_content(result):
	if result is not Array:
		GlobalSignal.emit_signal("_event_not_match")
		print_debug("错误：无法匹配事件")
		return
	else:
		GlobalSignal.emit_signal("_lock_change")
		playing_array = result
		# 完成本地化处理
		# 事件数组[-1]必须是文本
		var regex = RegEx.new()
		regex.compile("\\{([^}]+)\\}")
		for i in playing_array:
			if i[-1] is not String:
				pass
			else:
				var results = regex.search_all(i[-1])
				for t_match in results:
					var mark = t_match.get_string(1)
					if mark == "select_one":
						mark = GlobalVar.in_game_data["select_one"]
					if GlobalVar.module_temp_data["character"].has(mark):
						i[-1] = i[-1].replace(t_match.get_string(0), GlobalVar.module_temp_data["character"][str(mark)]["info"]["nickname"][GlobalSys.system_lang_zone])
		wait_for_choice = false
		self.append_text("\n")
		push_event_content()

# 推送文本 主逻辑
func push_event_content():
	if wait_for_choice == true:
		return
	if playing_array.size() == 0:
		GlobalSignal.emit_signal("_update_stage")
	if playing_array.size() > 0:
		var content = playing_array.pop_back()
		if playing_array.size() == 0:
			GlobalSignal.emit_signal("_lock_change")
		for i in content[0]:
			if i[0] == "select_one":
					i[0] = GlobalVar.in_game_data["select_one"]
		var t_text = content[-1]
		match content[0]:
			"call":
				match content[1]:
					"stage_switch":
						GlobalSignal.emit_signal("_stage_switch",content[2])
						return
					"":
						choice_count += 1
						self.append_text("\n" + "[url=" + "|" + t_text + "]" + t_text + "[/url]")
						if playing_array.size() != 0:
							if playing_array[-1][0] == "call":
								push_event_content()
								return
							else:
								wait_for_choice = true
								return
					_: 
						choice_count += 1
						self.append_text("\n" + "[url=" + content[2] + "|" + t_text + "]" + t_text + "[/url]")
						if playing_array.size() != 0:
							if playing_array[-1][0] == "call":
								push_event_content()
								return
							else:
								wait_for_choice = true
								return
			"bonus":
				var bonus = content[1]
				for i in bonus:
					if i[0] == "select_one":
						i[0] = GlobalVar.in_game_data["select_one"]
					GlobalVar.module_temp_data["character"][i[0]]["detail"][i[1]][i[2]] += i[3]
					match GlobalSys.system_lang_zone:
						"en":
							var ftext = GlobalVar.module_temp_data["character"][i[0]]["info"]["name"]["en"]
							var stext = GlobalVar.module_temp_data["variable"]["normal"]["status"][i[2]]["en"]
							self.append_text("\n" + ftext + "'s" + stext + "increase" + " " + str(int(i[3])) + " " + "point")
							push_event_content()
							return
						"zh":
							var ftext = GlobalVar.module_temp_data["character"][i[0]]["info"]["name"]["zh"]
							var stext = GlobalVar.module_temp_data["variable"]["normal"]["status"][i[2]]["zh"]
							self.append_text("\n" + ftext + "的" + stext + "增加了"  + " " + str(int(i[3])) + " "  + "点")
							push_event_content()
							return
						"jp":
							var ftext = GlobalVar.module_temp_data["character"][i[0]]["info"]["name"]["jp"]
							var stext = GlobalVar.module_temp_data["variable"]["normal"]["status"][i[2]]["jp"]
							self.append_text("\n" + ftext + "の" + stext + "が" + " "  + str(int(i[3])) + " "  + "点増えました")
							push_event_content()
							return
			_:
				if content[0] == "select_one":
					content[0] = GlobalVar.in_game_data["select_one"]
				if GlobalVar.module_temp_data["colortable"].keys().has(content[0]):
					self.append_text("\n" + "[color=" + GlobalVar.module_temp_data["colortable"][content[0]] + "]" + t_text + "[/color]")
				else:
					self.append_text("\n" + t_text)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.double_click:
				if playing_array.size() > 0:
					push_event_content()
			else:
				if playing_array.size() > 0:
					push_event_content()
	if event.is_action_pressed("ui_accept"):
		if playing_array.size() > 0:
			push_event_content()
			
