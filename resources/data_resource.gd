extends Resource
class_name DataResource

enum LetterQuestionType {
	NAME=0,
	SOUND=1
}

@export var letters:Array[LetterResource] = []
@export var words:Array[WordResource] = []

# Get for learning letters
func get_letter_set(num_letters:int=3, seen:bool=false) -> Array[LetterResource]:
	var return_list:Array[LetterResource] = []
	var lowest_priority = 1000
	var lowest_priority_count = 0
	var total_unseen = 0
	for letter in letters:
		# check counts for all types
		if not letter.is_seen:
			total_unseen += 1
			if letter.priority < lowest_priority:
				lowest_priority = letter.priority
				lowest_priority_count = 1
			elif letter.priority == lowest_priority:
				lowest_priority_count += 1
	if total_unseen < num_letters:
		# return only the unseen letters
		for letter in letters:
			if not letter.is_seen:
				return_list.append(letter)
	else:
		var added = 0
		while added < num_letters:
			# continue until added the correct number of letters
			for letter in letters:
				if added < num_letters and not letter.is_seen and letter.priority == lowest_priority:
					# add if the letter is not seen, has the lowest priority and if there are not enough letters added
					added += 1
					return_list.append(letter)
			lowest_priority += 1
	return return_list


# Get for practice letters
func get_learning_letter_set(num_letters:int=3) -> Array[LetterResource]:
	var return_list:Array[LetterResource] = []
	var lowest_seen = 1000
	var lowest_seen_count = 0
	var total_unseen = 0
	for letter in letters:
		# check counts for all types
		if letter.is_seen:
			total_unseen += 1
			if letter.times_practiced < lowest_seen:
				lowest_seen = letter.times_practiced
				lowest_seen_count = 1
			elif letter.times_practiced == lowest_seen:
				lowest_seen_count += 1
	if total_unseen < num_letters:
		# return only the unseen letters
		for letter in letters:
			if letter.is_seen:
				return_list.append(letter)
	else:
		var added = 0
		while added < num_letters:
			# continue until added the correct number of letters
			for letter in letters:
				if added < num_letters and letter.is_seen and letter.times_practiced == lowest_seen:
					# add if the letter is not seen, has the lowest times practiced and if there are not enough letters added
					added += 1
					return_list.append(letter)
			lowest_seen += 1
	for l in return_list:
		print(l.letter_name)
	return return_list


func get_confusion_letters_no_crossover(num_letters:int, letter:LetterResource, data:LetterQuestionType) -> Array[LetterResource]:
	print("Letter: ", letter.letter_name)
	var confusion_letters:Array[LetterResource] = []
	var num_selected = 0
	var num_total = len(letters)
	while num_selected < num_letters:
		# select random number between 0 and num-letters - 1
		var rand = RandomNumberGenerator.new()
		var i = rand.randi_range(0, num_total-1)
		# check if letter is given letter
		var pick = letters[i]
		if pick != letter and pick not in confusion_letters:
			# check if letter has no confusing data
			if data == LetterQuestionType.NAME:
				confusion_letters.append(pick)
				num_selected += 1
			elif data == LetterQuestionType.SOUND:
				if pick.letter_sound != letter.letter_sound:
					confusion_letters.append(pick)
					num_selected += 1
	print("Letters: ")
	for l in confusion_letters:
		print(l.letter_name)
	return confusion_letters

func get_word_set(num_words:int=3) -> Array[WordResource]:
	return []
