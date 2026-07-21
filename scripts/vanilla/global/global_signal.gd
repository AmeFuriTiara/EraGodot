extends Node

signal _no_module_found

# 控制流信号
# 主菜单
signal _new_game
signal _load_game

# 主界面
signal _update_stage

# 场景相关信号
# 动画
signal _stage_switch
signal _stage_switch_done
signal _ani_menu_out

signal _init_load_done

# 游戏运行时信号
signal _env_status_change
signal _character_status_change
signal _stage_status_change

signal _require_event_content
signal _return_event_content
signal _event_not_match

signal _lock_change
signal _line_edit_update
signal _call_function
signal _time_flow
