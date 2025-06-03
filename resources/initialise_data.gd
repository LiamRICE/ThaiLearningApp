extends Node
class_name InitialiseData

var save_path_letters := "user://player_data.tres" 
var save_path_words := "user://player_data_words.tres"
var data:DataResource

func initialise():
	var loaded_data = check_save()
	if not loaded_data:
		data = DataResource.new()
		print("Data initialised")
		initialise_data_letters()
		initialise_data_words()
		save()
	else:
		print("Existing data detected")
		data = loaded_data
		var num_learned = 0
		var num_to_learn = 0
		for d in data.letters:
			print(d.letter_name)
			if d.is_seen:
				num_learned += 1
			else:
				num_to_learn += 1
		print("Num Learned = ", num_learned)
		print("Num to learn = ", num_to_learn)
	return data


func save():
	ResourceSaver.save(data, save_path_letters)


func check_save() -> Resource:
	print("Checking save...")
	var loaded_data = ResourceLoader.load(save_path_letters)
	print("Loaded data :", loaded_data)
	return loaded_data


func delete_save_data():
	# delete file path
	DirAccess.remove_absolute(save_path_letters)
	# empty resource
	data = null


func initialise_data_letters():
	# definition of full thai letters
	var thai_letter_resources:Array[LetterResource] = [
		# consonants
		LetterResource.create("ko kai", "ก", "k", 1),
		LetterResource.create("kho khai", "ข", "kh -k", 2),
		LetterResource.create("kho khuat", "ฃ", "kh -k", 3),
		LetterResource.create("kho kwai", "ค", "kh -k", 1),
		LetterResource.create("kho khon", "ฅ", "kh -k", 3),
		LetterResource.create("kho rakhang", "ฆ", "kh -k", 4),
		LetterResource.create("ngo ngu", "ง", "ng", 1),
		LetterResource.create("cho chan", "จ", "ch -t", 1),
		LetterResource.create("cho ching", "ฉ", "ch", 2),
		LetterResource.create("cho chang", "ช", "ch -t", 2),
		LetterResource.create("so so", "ซ", "s -t", 1),
		LetterResource.create("cho choe", "ฌ", "ch -t", 3),
		LetterResource.create("yo ying", "ญ", "y -n", 1),
		LetterResource.create("do chada", "ฎ", "d -t", 3),
		LetterResource.create("to patak", "ฏ", "t", 3),
		LetterResource.create("tho than", "ฐ", "th -t", 4),
		LetterResource.create("tho montho", "ฑ", "th/d -t", 3),
		LetterResource.create("tho phu thao", "ฒ", "th -t", 3),
		LetterResource.create("no nen", "ณ", "n", 1),
		LetterResource.create("do dek", "ด", "d -t", 1),
		LetterResource.create("to tao", "ต", "t", 1),
		LetterResource.create("tho thung", "ถ", "th -t", 3),
		LetterResource.create("tho thahan", "ท", "th -t", 2),
		LetterResource.create("tho thong", "ธ", "th -t", 3),
		LetterResource.create("no nu", "น", "n", 1),
		LetterResource.create("bo baimai", "บ", "b -p", 2),
		LetterResource.create("po pla", "ป", "p", 1),
		LetterResource.create("pho phueng", "ผ", "ph", 1),
		LetterResource.create("fo fa", "ฝ", "f", 1),
		LetterResource.create("pho phan", "พ", "ph -p", 2),
		LetterResource.create("fo fan", "ฟ", "f -p", 2),
		LetterResource.create("pho samphao", "ภ", "ph -p", 3),
		LetterResource.create("mo ma", "ม", "m", 1),
		LetterResource.create("yo yak", "ย", "y", 1),
		LetterResource.create("ro ruea", "ร", "r -n", 1),
		LetterResource.create("lo ling", "ล", "l -n", 1),
		LetterResource.create("wo waen", "ว", "w", 2),
		LetterResource.create("so sala", "ศ", "s -t", 2),
		LetterResource.create("so ruesi", "ษ", "s -t", 3),
		LetterResource.create("so suea", "ส", "s -t", 2),
		LetterResource.create("ho hip", "ห", "h", 3),
		LetterResource.create("lo chula", "ฬ", "l -n", 2),
		LetterResource.create("o ang", "อ", "-", 1),
		LetterResource.create("ho nok huk", "ฮ", "h", 4),
		# vowels
		LetterResource.create("sara a", "◌ะ", "a (short)", 1),
		LetterResource.create("sara a", "◌ั◌", "a (short)", 1),
		LetterResource.create("sara a", "◌า", "a (long)", 1),
		LetterResource.create("sara i", "◌ิ", "i (short)", 1),
		LetterResource.create("sara i", "◌ี", "i (long)", 1),
		LetterResource.create("sara ue", "◌ึ", "ue (short)", 1),
		LetterResource.create("sara ue", "◌ือ", "ue (long)", 1),
		LetterResource.create("sara ue", "◌ื◌", "ue (long)", 1),
		LetterResource.create("sara u", "◌ุ", "u (short)", 1),
		LetterResource.create("sara u", "◌ู", "u (long)", 1),
		LetterResource.create("sara e", "เ◌ะ", "e (short)", 1),
		LetterResource.create("sara e", "เ◌็◌", "e (short)", 1),
		LetterResource.create("sara e", "เ◌", "e (long)", 1),
		LetterResource.create("sara ae", "แ◌ะ", "ae (short)", 1),
		LetterResource.create("sara ae", "แ◌็◌", "ae (short)", 1),
		LetterResource.create("sara ae", "แ◌", "ae (long)", 1),
		LetterResource.create("sara o", "โ◌ะ", "o (short)", 1),
		LetterResource.create("sara o", "โ◌", "o (long)", 1),
		LetterResource.create("sara o", "เ◌าะ", "o (short)", 1),
		LetterResource.create("sara o", "◌็อ◌", "o (short)", 1),
		LetterResource.create("sara o", "◌อ", "o (long)", 1),
		LetterResource.create("sara o", "◌็", "o (long)", 1),
		LetterResource.create("sara oe", "เ◌อะ", "oe (short)", 1),
		LetterResource.create("sara oe", "เ◌อ", "o (long)", 1),
		LetterResource.create("sara oe", "เ◌ิ◌", "o (long)", 1),
		# diphthongs
		LetterResource.create("sara ia", "เ◌ียะ", "ia (short)", 2),
		LetterResource.create("sara ia", "เ◌ีย", "ia (long)", 2),
		LetterResource.create("sara uea", "เ◌ือะ", "uea (short)", 2),
		LetterResource.create("sara uea", "เ◌ือ", "uea (long)", 2),
		LetterResource.create("sara ua", "◌ัวะ", "ua (short)", 2),
		LetterResource.create("sara ua", "◌ัว", "ua (long)", 2),
		LetterResource.create("sara ua", "◌ว◌", "ua (long)", 2),
		# phonemic diphthongs
		LetterResource.create("sara a + yo yak", "◌ัย", "ai (short)", 3),
		LetterResource.create("sara ai", "ใ◌", "ai (short)", 3),
		LetterResource.create("sara ai", "ไ◌", "ai (short)", 3),
		LetterResource.create("sara ai", "ไ◌ย", "ai (short)", 3),
		LetterResource.create("sara ai", "◌็อ◌", "o (short)", 3),
		# extra vowels
		LetterResource.create("sara am", "ำ", "am", 4),
		LetterResource.create("rue", "ฤ", "rue (short)", 4),
		LetterResource.create("lue", "ฦ", "lue (short)", 4),
		LetterResource.create("rue", "ฤๅ", "rue (long)", 4),
		LetterResource.create("lue", "ฦๅ", "lue (long)", 4)
	]
	
	# initialise thai data
	data.letters = thai_letter_resources
	
	# view loaded data
	var num_1 = 0
	var num_2 = 0
	var num_3 = 0
	var num_4 = 0
	for l in thai_letter_resources:
		print("Letter: ", l.letter_text)
		print("Letter Name: ", l.letter_name)
		print("Letter Sound: ", l.letter_sound)
		print("")
		if l.priority == 1:
			num_1 += 1
		elif l.priority == 2:
			num_2 += 1
		elif l.priority == 3:
			num_3 += 1
		elif l.priority == 4:
			num_4 += 1
		
	
	print("Num priority 1 = ", num_1)
	print("Num priority 2 = ", num_2)
	print("Num priority 3 = ", num_3)
	print("Num priority 4 = ", num_4)
	# set data resource letters
	


func initialise_data_words():
	# create list of words to learn
	var word_list_array = [
		WordResource.create("กิน", "eat", "kin", data.get_letter_list_from_names(["ก", "◌ิ", "น"]), 1)
	]
	data.words = word_list_array
