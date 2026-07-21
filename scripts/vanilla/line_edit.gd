extends LineEdit

var edit_lock:bool = false

func _ready() -> void:
	GlobalSignal.connect("_lock_change",Callable(self,"switch_lock"))

func switch_lock():
	match edit_lock:
		false:
			self.editable = false
			edit_lock = true
		true:
			self.editable = true
			edit_lock = false

func _on_text_submitted(new_text: String) -> void:
	if self.has_focus() == true && self.text != "":
		GlobalSignal.emit_signal("_line_edit_update",new_text)
		self.unedit()
		self.text = ""

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if edit_lock == false:
			self.edit()
