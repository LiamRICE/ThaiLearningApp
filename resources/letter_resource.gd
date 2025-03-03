extends Resource
class_name LetterResource

@export var letter_name:String = ""
@export var letter_text:String = ""
@export var letter_sound:String = ""
@export var is_seen:bool = false
@export var times_practiced:int = 0
@export var priority = 0

static func create(name:String, text:String, sound:String, priority:int, is_seen:bool=false, practiced:int=0) -> LetterResource:
	var res = LetterResource.new()
	res.letter_name = name
	res.letter_text = text
	res.letter_sound = sound
	res.is_seen = is_seen
	res.times_practiced = practiced
	res.priority = priority
	return res
