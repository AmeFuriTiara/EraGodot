extends VBoxContainer

@onready var social_command_pool = $Social/ScrollContainer/ButtonPool
@onready var special_command_pool = $Special/ScrollContainer/ButtonPool
@onready var sekuhara_command_pool = $Sekuhara/ScrollContainer/ButtonPool
@onready var stage_command_pool = $Stage/ScrollContainer/ButtonPool
@onready var cmd_button = preload("res://stage/command_button.tscn")

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	for node in social_command_pool.get_children():
		node.free()
	for node in special_command_pool.get_children():
		node.free()
	for node in sekuhara_command_pool.get_children():
		node.free()
	for node in stage_command_pool.get_children():
		node.free()
	var id_giver = 0
	var social_keys = GlobalVar.module_temp_data["command"]["social"].keys()
	var special_keys = GlobalVar.module_temp_data["command"]["special"].keys()
	var sekuhara_keys = GlobalVar.module_temp_data["command"]["sekuhara"].keys()
	var stage_keys = GlobalVar.module_temp_data["command"]["stage"].keys()
	for i in social_keys:
		var cmd = GlobalVar.module_temp_data["command"]["social"][i]
		if cmd["condition"] != []:
			var t_condition = cmd["condition"]
			t_condition[0] = GlobalVar.in_game_data["select_one"]
			if GlobalFunc._condition_checker([t_condition,i]) == true:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = false
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				social_command_pool.add_child(cb_node)
		else:
			if cmd["call"][0] == "function":
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = true
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				social_command_pool.add_child(cb_node)
			else:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = false
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				social_command_pool.add_child(cb_node)
	for i in special_keys:
		var cmd = GlobalVar.module_temp_data["command"]["special"][i]
		if cmd["condition"] != []:
			var t_condition = cmd["condition"]
			t_condition[0] = GlobalVar.in_game_data["select_one"]
			if GlobalFunc._condition_checker([t_condition,i]) == true:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				special_command_pool.add_child(cb_node)
		else:
			if cmd["call"][0] == "function":
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = true
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				special_command_pool.add_child(cb_node)
			else:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = false
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				special_command_pool.add_child(cb_node)
	for i in sekuhara_keys:
		var cmd = GlobalVar.module_temp_data["command"]["sekuhara"][i]
		if cmd["condition"] != []:
			var t_condition = cmd["condition"]
			t_condition[0] = GlobalVar.in_game_data["select_one"]
			if GlobalFunc._condition_checker([t_condition,i]) == true:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				sekuhara_command_pool.add_child(cb_node)
		else:
			if cmd["call"][0] == "function":
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = true
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				sekuhara_command_pool.add_child(cb_node)
			else:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = false
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				sekuhara_command_pool.add_child(cb_node)
	for i in stage_keys:
		var cmd = GlobalVar.module_temp_data["command"]["stage"][i]
		if cmd["condition"] != []:
			var t_condition = cmd["condition"]
			t_condition[0] = GlobalVar.in_game_data["select_one"]
			if GlobalFunc._condition_checker([t_condition,i]) == true:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				stage_command_pool.add_child(cb_node)
		else:
			if cmd["call"][0] == "function":
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = true
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				stage_command_pool.add_child(cb_node)
			else:
				id_giver += 1
				var cb_node = cmd_button.instantiate()
				cb_node.s_id = str(id_giver)
				cb_node.s_name = i
				cb_node.is_function = false
				cb_node.text = "[ " + str(id_giver) + " ]" + " " + cmd[GlobalSys.system_lang_zone]
				stage_command_pool.add_child(cb_node)
