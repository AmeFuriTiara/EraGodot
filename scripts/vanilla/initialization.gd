extends Control

# UI中间段展开状态
var mid_on:bool = true

var check_result:Dictionary = {}

var load_holder:String

@onready var main_ani:AnimationPlayer = $MainAniPlayer
@onready var mid_ani:AnimationPlayer = $MainContainer/TripCut/MidAniPlayer
@onready var main_menu_mid = $MainMenu/Mid/Mid
const main_menu_icon = preload("res://stage/mainmenu_icon.tscn")

func _ready() -> void:
	GlobalSignal.connect("_no_module_found",Callable(self,"show_warning"))
	GlobalSignal.connect("_ani_menu_out",Callable(self,"menu_out"))
	GlobalSignal.connect("_init_load_done",Callable(self,"mid_show"))
	check_result = GlobalFunc.check_module()
	if check_result != {}:
		update_icons()

func show_warning():
	$MainMenu/Mid/Mid/Warning.visible = true

# 匹配查询到的模组数据
func update_icons():
	var list = check_result.keys()
	for i in list:
		var icon = main_menu_icon.instantiate()
		var image = Image.new()
		var load_result = image.load_from_file("user://modules/" + i + "/" + check_result[i]["module_relate_path"]["logo"])
		var texture = ImageTexture.create_from_image(load_result)
		icon.get_node("IconTexture").texture = texture
		icon.get_node("IconName").text = check_result[i]["module_name"]
		icon.s_name = i
		main_menu_mid.add_child(icon)

func menu_out(any:String):
	load_holder = any
	main_ani.play("主菜单淡出")

func mid_show():
	mid_ani.play("总界面开")

func _on_main_ani_player_animation_finished(anim_name: StringName) -> void:
	GlobalFunc._load_module(load_holder)
