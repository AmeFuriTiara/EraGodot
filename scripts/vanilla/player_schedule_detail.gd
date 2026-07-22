extends Button

var s_name = "check_schedule"
var is_function = "true"
var button_lock:bool = false
var stand_by_color:String = "#FFFFFF"
var block_color:String = "#666666"

func _ready() -> void:
	GlobalSignal.connect("_lock_change",Callable(self,"switch_lock"))
	GlobalSignal.connect("_init_load_done",Callable(self,"native_update_data"))
	GlobalSignal.connect("_update_stage",Callable(self,"native_update_data"))

func native_update_data():
	if GlobalVar.module_temp_data["command"]["special"].has(s_name):
		self.text = GlobalVar.module_temp_data["command"]["special"][s_name][GlobalSys.system_lang_zone]

func switch_lock():
	match button_lock:
		false:
			self_modulate = block_color
			button_lock = true
		true:
			self_modulate = stand_by_color
			button_lock = false

func _on_pressed() -> void:
	if button_lock == false:
		GlobalSignal.emit_signal("_call_function",s_name)
		GlobalSignal.emit_signal("_lock_change")
