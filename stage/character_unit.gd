extends VBoxContainer

var s_name:String
var main_status:String = "闲逛中"

@onready var s_texture_node = $ChracterIcon
@onready var s_name_label = $Name
@onready var s_buff_pool = $ChracterIcon/BuffPool

@onready var buff_panel = preload("res://stage/buff_panel.tscn")

func _ready() -> void:
	GlobalSignal.connect("_init_load_done",Callable(self,"init_self"))

func init_self():
	var temp = "asari"
	# 加载对应角色名称
	s_name_label.text = GlobalVar.module_temp_data["character"][temp]["info"]["name"][GlobalSys.system_lang_zone]
	# 加载对应角色头像
	var t_path = GlobalFunc._get_sprite_path(["character",temp,"icon"])
	if t_path != null:
		var image = Image.new()
		var load_result = image.load_from_file(t_path)
		s_texture_node.texture = ImageTexture.create_from_image(load_result)
