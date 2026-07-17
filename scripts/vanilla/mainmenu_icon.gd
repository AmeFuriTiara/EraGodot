extends VBoxContainer

var s_name:String
var mouse_in:bool = false
var load_lock:bool = false
var def_module_color = "#c7c7c7"
var light_module_color = "#ffffff"

func _ready() -> void:
	$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)

func _on_icon_texture_mouse_entered() -> void:
	mouse_in = true
	$IconTexture.self_modulate = Color.from_string(light_module_color,Color.ALICE_BLUE)

func _on_icon_texture_mouse_exited() -> void:
	mouse_in = false
	$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)

func _on_icon_texture_gui_input(event: InputEvent) -> void:
	if mouse_in == true && load_lock == false:
		if event is InputEventMouseButton:
			if event.pressed:
				if event.double_click:
					load_lock = true
					GlobalSignal.emit_signal("_ani_menu_out",s_name)
				else:
					load_lock = true
					GlobalSignal.emit_signal("_ani_menu_out",s_name)
