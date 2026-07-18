extends Control

# UI中间段展开状态
var mid_on:bool = false

var check_result:Dictionary = {}

var load_holder:String

# 菜单相关
@onready var main_ani:AnimationPlayer = $MainAniPlayer
@onready var main_menu_mid = $MainMenu/Mid/Mid

# 主界面相关
@onready var mid_ani:AnimationPlayer = $MainContainer/TripCut/MidAniPlayer
@onready var mid_env_status_label:RichTextLabel = $MainContainer/TripCut/Mid/MidContainer/EnvStatus
@onready var mid_stage_status_label:RichTextLabel = $MainContainer/TripCut/Mid/MidContainer/StageStatus

const main_menu_icon = preload("res://stage/mainmenu_icon.tscn")

func _ready() -> void:
	GlobalSignal.connect("_no_module_found",Callable(self,"show_warning"))
	GlobalSignal.connect("_ani_menu_out",Callable(self,"menu_out"))
	GlobalSignal.connect("_stage_switch",Callable(self,"stage_change"))
	GlobalSignal.connect("_stage_switch_done",Callable(self,"stage_change_clear"))
	GlobalSignal.connect("_init_load_done",Callable(self,"mid_show"))
	$MainContainer/TripCut/Mid.size_flags_stretch_ratio = 0.0
	$MainMenu.visible = true
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
		var load_result = Image.load_from_file("user://modules/" + i + "/" + check_result[i]["module_relate_path"]["logo"])
		var texture = ImageTexture.create_from_image(load_result)
		icon.get_node("IconTexture").texture = texture
		icon.get_node("IconName").text = check_result[i]["module_name"]
		icon.s_name = i
		main_menu_mid.add_child(icon)

func menu_out(any:String):
	load_holder = any
	main_ani.play("主菜单淡出")

func stage_change(any:Array):
	mid_ani.play("总界面关")
	await mid_ani.animation_finished
	var s_text = GlobalVar.module_temp_data["stage"][any[0]][GlobalSys.system_lang_zone]
	var d_text = GlobalVar.module_temp_data["stage"][any[0]][any[1]][GlobalSys.system_lang_zone]
	mid_stage_status_label.text = s_text + " " + d_text + str(GlobalVar.game_temp_data["clean"]) + " " + GlobalVar.game_temp_data["description"]
	GlobalSignal.emit_signal("_stage_switch_done")

func stage_change_clear():
	mid_ani.play("总界面开")

func mid_show():
	mid_ani.play("总界面开")

func _on_main_ani_player_animation_finished(_anim_name: StringName) -> void:
	GlobalFunc._load_module(load_holder)

func _on_mid_ani_player_animation_finished(_anim_name: StringName) -> void:
	match mid_on:
		true:
			mid_on = false
		false:
			mid_on = true
