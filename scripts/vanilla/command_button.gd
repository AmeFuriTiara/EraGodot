extends Button

var s_id:String
var s_name:String
var is_function:bool
var button_lock:bool = false
var stand_by_color:String = "#FFFFFF"
var block_color:String = "#666666"

func _ready() -> void:
	GlobalSignal.connect("_lock_change",Callable(self,"switch_lock"))
	GlobalSignal.connect("_line_edit_update",Callable(self,"line_edit_match"))

func switch_lock():
	match button_lock:
		false:
			self_modulate = block_color
			button_lock = true
		true:
			self_modulate = stand_by_color
			button_lock = false

func line_edit_match(any:String):
	if any.is_valid_int():
		var num = any.to_int()
		if num == int(s_id):
			if is_function == false && button_lock == false:
				GlobalSignal.emit_signal("_require_event_content",s_name)
			else:
				GlobalSignal.emit_signal("_call_function",s_name)
				GlobalSignal.emit_signal("_lock_change")
				

func _on_pressed() -> void:
	if is_function == false && button_lock == false:
		GlobalSignal.emit_signal("_require_event_content",s_name)
	else:
		GlobalSignal.emit_signal("_call_function",s_name)
		GlobalSignal.emit_signal("_lock_change")
