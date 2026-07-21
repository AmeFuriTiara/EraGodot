extends Button

var s_name = "roster"
var is_function = "true"
var button_lock:bool = false
var stand_by_color:String = "#FFFFFF"
var block_color:String = "#666666"

func _ready() -> void:
	GlobalSignal.connect("_lock_change",Callable(self,"switch_lock"))

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
