extends VBoxContainer

var s_name:String
var has_save_folder:bool = false
var mouse_in:bool = false
var mouse_in_side_menu:bool = false
var load_lock:bool = false
var side_menu_shown:bool = false
var def_module_color = "#c7c7c7"
var light_module_color = "#ffffff"

func _ready() -> void:
	$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)

func _on_icon_texture_mouse_entered() -> void:
	mouse_in = true
	$IconTexture.self_modulate = Color.from_string(light_module_color,Color.ALICE_BLUE)

func _on_icon_texture_mouse_exited() -> void:
	mouse_in = false
	if side_menu_shown == false && $IconAniPlayer.is_playing() == false:
		$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)

func _on_icon_texture_gui_input(event: InputEvent) -> void:
	if mouse_in == true && has_save_folder == false:
		if event is InputEventMouseButton:
			if event.is_action_pressed("mouse_left_click"):
				if event.double_click:
					load_lock = true
					GlobalSignal.emit_signal("_new_game",s_name)
					return
				else:
					load_lock = true
					GlobalSignal.emit_signal("_new_game",s_name)
					return
	if mouse_in == true && side_menu_shown == false && has_save_folder == true:
		if event is InputEventMouseButton:
			if event.is_action_pressed("mouse_left_click"):
				if event.double_click:
					$IconAniPlayer.play("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = true
					return
				else:
					$IconAniPlayer.play("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = true
					return
	if mouse_in == true && side_menu_shown == true:
		if event is InputEventMouseButton:
			if event.is_action_pressed("mouse_left_click"):
				if event.double_click:
					$IconAniPlayer.play_backwards("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = false
					return
				else:
					$IconAniPlayer.play_backwards("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = false
					return

func _input(event: InputEvent) -> void:
	if mouse_in == false && mouse_in_side_menu == false && side_menu_shown == true:
		if event is InputEventMouseButton:
			if event.is_action_pressed("mouse_left_click"):
				if event.double_click:
					$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)
					$IconAniPlayer.play_backwards("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = false
					return
				else:
					$IconTexture.self_modulate = Color.from_string(def_module_color,Color.ALICE_BLUE)
					$IconAniPlayer.play_backwards("显示")
					await  $IconAniPlayer.animation_finished
					side_menu_shown = false
					return

func _on_button_mouse_entered() -> void:
	mouse_in_side_menu = true

func _on_button_mouse_exited() -> void:
	mouse_in_side_menu = false

func _on_button_2_mouse_entered() -> void:
	mouse_in_side_menu = true

func _on_button_2_mouse_exited() -> void:
	mouse_in_side_menu = false

func _on_button_pressed() -> void:
	if has_save_folder == true:
		load_lock = true
		GlobalSignal.emit_signal("_new_game",s_name)

func _on_button_2_pressed() -> void:
	load_lock = true
