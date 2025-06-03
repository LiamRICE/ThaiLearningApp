extends Resource
class_name DataResource

enum LetterQuestionType {
	NAME=0,
	SOUND=1
}

@export var letters:Array[LetterResource] = []
@export var words:Array[WordResource] = []


func scale(x:int, max:int, min:int) -> int:
	# scale result inversly between 1 and 10
	var result = 10
	if (max - min) != 0:
		result = ((10 - 1) * (x - min)) / (max - min)
	# safety check
	if result <= 0:
		result = 1
	elif result >= 10:
		result = 10
	# reverse probability
	return 11 - result


func get_letter_set(num_letters:int=3, seen:bool=false) -> Array[LetterResource]:
	var set_list:Array[LetterResource] = []
	var min_priority:int = -1
	# find lowest priority
	for item in letters:
		if item.is_seen == seen and (item.priority < min_priority or min_priority < 0):
			min_priority = item.priority
	# cycle through the letters and pick all the ones with lowest priority
	var min_practiced:int = -1
	var max_practiced:int = -1
	var num = 0
	while num < num_letters:
		for item in letters:
			if item.priority <= min_priority and item.is_seen == seen:
				set_list.append(item)
				num += 1
				if item.times_practiced <= min_practiced or min_practiced <= -1:
					min_practiced = item.times_practiced
				if item.times_practiced >= max_practiced or max_practiced <= -1:
					max_practiced = item.times_practiced
		min_priority += 1
	# select random number of items based on inverse of times practiced
	var probabilities:Array[int] = []
	var total = 0
	for item in set_list:
		var value = scale(item.times_practiced, max_practiced, min_practiced)
		probabilities.append(value)
		total += value
	# select num_letters letters
	var selected:Array[LetterResource] = []
	var pick = false
	while len(selected) < num_letters:
		var random = randi_range(1, total)
		for i in range(len(probabilities)):
			if not(pick) and random <= probabilities[i]:
				selected.append(set_list[i])
				pick = true
			else:
				random -= probabilities[i]
		pick = false
	
	print("Number of letters selected :", len(selected))
	return selected


# Get for learning letters
#func get_letter_set(num_letters:int=3, seen:bool=false) -> Array[LetterResource]:
	#var return_list:Array[LetterResource] = []
	#var lowest_priority = 1000
	#var lowest_priority_count = 0
	#var total_unseen = 0
	#for letter in letters:
		## check counts for all types
		#if not letter.is_seen:
			#total_unseen += 1
			#if letter.priority < lowest_priority:
				#lowest_priority = letter.priority
				#lowest_priority_count = 1
			#elif letter.priority == lowest_priority:
				#lowest_priority_count += 1
	#if total_unseen < num_letters:
		## return only the unseen letters
		#for letter in letters:
			#if not letter.is_seen:
				#return_list.append(letter)
	#else:
		#var added = 0
		#while added < num_letters:
			## continue until added the correct number of letters
			#for letter in letters:
				#if added < num_letters and not letter.is_seen and letter.priority == lowest_priority:
					## add if the letter is not seen, has the lowest priority and if there are not enough letters added
					#added += 1
					#return_list.append(letter)
			#lowest_priority += 1
	#return return_list


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


func get_letter_from_name(name:String) -> LetterResource:
	var ret:LetterResource
	for let in letters:
		if let.name == name:
			ret = let
	return ret


func get_letter_list_from_names(names:Array[String]) -> Array[LetterResource]:
	var ret:Array[LetterResource]
	for name in names:
		ret.append(self.get_letter_from_name(name))
	return ret
