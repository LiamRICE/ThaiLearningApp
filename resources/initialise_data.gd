extends Node
class_name InitialiseData

var save_path := "user://player_data.tres" 
var data:DataResource

func initialise():
	var loaded_data = check_save()
	if not loaded_data:
		data = DataResource.new()
		print("Data initialised")
		initialise_data()
		save()
	else:
		print("Existing data detected")
		data = loaded_data
	return data


func save():
	ResourceSaver.save(data, save_path)


func check_save() -> Resource:
	print("Checking save...")
	var loaded_data = ResourceLoader.load(save_path)
	print("Loaded data :", loaded_data)
	return loaded_data


func delete_save_data():
	# delete file path
	DirAccess.remove_absolute(save_path)
	# empty resource
	data = null


func initialise_data():
	# define thai letters
	var thai_letters:Array[String] = ["ก", "ข", "ฃ"]
	# define thai letter names
	var thai_letter_names:Array[String] = ["ko kai", "kho khai", "kho khuat"]
	# define thai letter sounds
	var thai_letter_sounds:Array[String] = ["k (g)", "kh- -k", "kh-"]
	# define thai letter priority
	var thai_letter_priority:Array[int] = [3, 2, 1]
	
	# initialise thai data
	data.letters = []
	for i in range(len(thai_letters)):
		var letter:LetterResource = LetterResource.new()
		letter.letter_text = thai_letters[i]
		letter.letter_name = thai_letter_names[i]
		letter.letter_sound = thai_letter_sounds[i]
		letter.priority = thai_letter_priority[i]
		data.letters.append(letter)
		
		print("Letter: ", letter.letter_text)
		print("Letter Name: ", letter.letter_name)
		print("Letter Sound: ", letter.letter_sound)
		print("")
	
