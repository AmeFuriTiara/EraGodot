extends Node

var now_module_name:String
var module_native_path:String
var module_temp_data:Dictionary = {
	"character":{},
	"event":{},
	"variable":{},
	"personality":{},
	"colortable":{}
}
var module_cfg:Dictionary
var module_relate_path:Dictionary
var character_json_path:Dictionary = {}
var event_json_path:Dictionary = {}

var playing_data:Dictionary = {}
var weather_lock:bool = false
var weather_lock_countdown:int = 0

var in_game_data:Dictionary = {
	"player_money":60000,
	"player_ping":"asari",
	"season":1,
	"week_count":4,
	"day_count":7,
	"time_h":22,
	"time_m":0,
	"time_mark":"",
	"weather":"sunny",
	"temperature":17,
	"now_location":["school","courtyard"],
	"character_on_stage":["player","asari","saki"],
	"select_one":""
}
