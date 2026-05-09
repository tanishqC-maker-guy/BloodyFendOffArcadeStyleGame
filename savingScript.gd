'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node

'''
This is the saving script, which handles saving for
the highscores displayed on the leader board.
'''

#the file location for the save file
const save_location = "user://SaveFile.json"

#this dictionary holds the highscores and names of the people who scored them
var contents_to_save: Dictionary = {
	"score_1": 0,
	"score_2": 0,
	"score_3": 0,
	"score_4": 0,
	"score_5": 0,
	"score_6": 0,
	"nickname_1": "",
	"nickname_2": "",
	"nickname_3": "",
	"nickname_4": "",
	"nickname_5": "",
	"nickname_6": "",
}

'''
This is the function that saves new data.
'''
func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()
	

'''
This function loads old data.
'''
func _load():
	if (FileAccess.file_exists(save_location)):
		var file = FileAccess.open(save_location,FileAccess.READ)
		
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		
		'''
		contents_to_save.score_1 = 0
		contents_to_save.score_2 = 0
		contents_to_save.score_3 = 0
		contents_to_save.score_4 = 0
		contents_to_save.score_5 = 0
		contents_to_save.score_6 = 0
		
		contents_to_save.nickname_1 = "___"
		contents_to_save.nickname_2 = "___"
		contents_to_save.nickname_3 = "___"
		contents_to_save.nickname_4 = "___"
		contents_to_save.nickname_5 = "___"
		contents_to_save.nickname_6 = "___"
		'''
		
		
		contents_to_save.score_1 = save_data.score_1
		contents_to_save.score_2 = save_data.score_2
		contents_to_save.score_3 = save_data.score_3
		contents_to_save.score_4 = save_data.score_4
		contents_to_save.score_5 = save_data.score_5
		contents_to_save.score_6 = save_data.score_6
		
		contents_to_save.nickname_1 = save_data.nickname_1
		contents_to_save.nickname_2 = save_data.nickname_2
		contents_to_save.nickname_3 = save_data.nickname_3
		contents_to_save.nickname_4 = save_data.nickname_4
		contents_to_save.nickname_5 = save_data.nickname_5
		contents_to_save.nickname_6 = save_data.nickname_6
		

'''
When the game starts, we load the previous save file so that
the highscores are ready.
'''

func _ready():
	_load()
