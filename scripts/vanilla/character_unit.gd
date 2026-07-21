extends VBoxContainer

@onready var s_texture_node = $ChracterIcon
@onready var s_name_label = $Name
@onready var s_buff_pool = $ChracterIcon/BuffPool
@onready var buff_panel = preload("res://stage/buff_panel.tscn")

var s_name:String = ""
var main_status:String = "闲逛中"
var high_light_yellow:String = "#F3A100"
var mouse_in:bool = false

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))
	native_update_data()

func native_update_data():
	pass
	if s_name == GlobalVar.in_game_data["select_one"]:
		$ChracterIcon/SelectMask.visible = true
	else:
		$ChracterIcon/SelectMask.visible = false

func init_self():
	# 加载对应角色名称
	s_name_label.text = GlobalVar.module_temp_data["character"][s_name]["info"]["name"][GlobalSys.system_lang_zone]
	# 加载对应角色头像
	var t_path = GlobalFunc._get_sprite_path(["character",s_name,"icon"])
	if t_path != null:
		var load_result = Image.load_from_file(t_path)
		s_texture_node.texture = ImageTexture.create_from_image(load_result)

func _on_chracter_icon_mouse_entered() -> void:
	mouse_in = true

func _on_chracter_icon_mouse_exited() -> void:
	mouse_in = false

func _on_chracter_icon_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.double_click:
				if mouse_in == true && GlobalVar.in_game_data["select_one"] != s_name:
					GlobalVar.in_game_data["select_one"] = s_name
					GlobalSignal.emit_signal("_update_stage")
			else:
				if mouse_in == true && GlobalVar.in_game_data["select_one"] != s_name:
					GlobalVar.in_game_data["select_one"] = s_name
					GlobalSignal.emit_signal("_update_stage")
