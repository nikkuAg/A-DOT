extends Node

var store = {
			"bought" : [true, false, false],
			"boughtA" : [true, false, false],
			"boughtP" : [false, false, false, false],
			"selectedW" :0,
			"selectedA" : 0,
			"selectedP" : -1
}

var power_start = 0 

var level = {
			"levels" : '0',
			"difficulty": '0',
			"levelME" : [true, false, false, false],
			"levelMH" : [true, false, false, false],
			"starE" : [0,0,0,0],
			"starH" : [0,0,0,0],
			"GstarE" : [0,0,0,0],
			"GstarH" : [0,0,0,0]
}


var gemPosition = {
			"x1" : [100, 100, 450, 530, 770, 950, 950, 1200, 1404, 1600],
			"y1" : [40, 300, 320, 220, 50, 50, 300, 200, 160, 70],
			"x2" : [50, 200, 340, 400, 600, 1000, 1150, 1570, 1600, 1850, 2200, 2300, 2500],
			"y2" : [300, 450, 270, 50, 200, 480, 80, 240, 440, 250, 60, 250, 380],
			"x3" : [140, 307, 395, 1193, 447, 1100, 1513, 1321, 814, 687, 910, 1295, 992, 910],
			"y3" : [331, 549, 1120, 852, 1120, 206, 30, 520, 521, 338, 655, 496, 637, 584, 833]
}

var save_store_path = 'user://store'
var save_level_path = 'user://level'

func _ready() -> void:
	load_store()
	store.selected = 0
	store.selectedA = 0
	save_store()
	load_level()
	for n in 4:
		level.starE[n] = 0
		level.starH[n] = 0
	save_level()

func reset_powerup():
	load_store()
	for n in 4:
		store.boughtP[n] = false
	store.selectedP = -1
	save_store()

func save_store():
	var file = File.new()
	file.open(save_store_path, file.WRITE_READ)
	file.store_var(store)
	file.close()
	
func load_store():
	var file = File.new()
	if not file.file_exists(save_store_path):
		return false
	file.open(save_store_path, file.READ)
	store = file.get_var()
	file.close()
	return true
	
func save_level():
	var file = File.new()
	file.open(save_level_path, file.WRITE_READ)
	file.store_var(level)
	file.close()
	
func load_level():
	var file = File.new()
	if not file.file_exists(save_level_path):
		return false
	file.open(save_level_path, file.READ)
	level = file.get_var()
	file.close()
	return true
