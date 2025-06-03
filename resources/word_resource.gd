extends Resource
class_name WordResource

@export var word_thai:String = ""
@export var word_english:String = ""
@export var word_romanisation:String = ""
@export var word_letters:Array[LetterResource] = []
@export var is_seen:bool = false
@export var times_practiced:int = 0
@export var priority = 0

static func create(thai_word:String, english_word:String, romanisation:String, letters:Array[LetterResource], priority=0, is_seen:bool=false, practiced:int=0) -> WordResource:
	var res = WordResource.new()
	res.word_thai = thai_word
	res.word_english = english_word
	res.word_romanisation = romanisation
	res.word_letters = letters
	res.is_seen = is_seen
	res.times_practiced = practiced
	res.priority = priority
	return res
