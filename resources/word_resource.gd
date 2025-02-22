extends Resource
class_name WordResource

@export var word_thai:String = ""
@export var word_english:String = ""
@export var word_romanisation:String = ""
@export var word_letters:Array[LetterResource] = []
@export var is_seen:bool = false
@export var times_practiced:int = 0
@export var priority = 0
