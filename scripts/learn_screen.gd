extends CanvasLayer

var data:DataResource

var count = 0

signal _back_button_pressed

@onready var learn_letters_button = $LearningPanel/VBoxContainer/VBoxContainer/LearnLettersButton
@onready var learn_words_button = $LearningPanel/VBoxContainer/VBoxContainer/LearnWordsButton
@onready var back_button = $LearningPanel/VBoxContainer/BackButton

# Main Panel
@onready var main_panel = $LearningPanel
@onready var exercise_type_1 = $LearningPanelExerciseType1
@onready var exercise_type_2 = $LearningPanelExerciseType2
@onready var exercise_type_3 = $LearningPanelExerciseType3
# Exercise Panels
@onready var exercise_panel_1 = $LearningPanelExerciseType1
@onready var exercise_label = $LearningPanelExerciseType1/VBoxContainer/VBoxContainer/ExerciseLabel
@onready var exercise_buttons = [
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton1,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton2,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton3,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton4
]
@onready var check_continue_button = $LearningPanelExerciseType1/VBoxContainer/VBoxContainer/CheckContinueButton
@onready var quict_lesson_button = $LearningPanelExerciseType1/VBoxContainer/QuitLessonButton

# stages
enum Stages {
	MENU = 0,
	LEARNING_LETTERS = 1,
	LEARNING_WORDS = 2
}
var stage:Stages
var current_panel:Panel

# set management
var letter_set:Array[int]


func _ready():
	count = 0
	stage = Stages.MENU
	current_panel = main_panel


func generate_letters_set():
	# fetch the indices of the letters for this set
	pass


func generate_next_exercise_letters_type_1():
	# generate the question and 4 options, including which one is the correct option
	pass


func switch_screen(source:Panel, destination:Panel):
	source.hide()
	destination.show()


func _on_back_button_pressed():
	_back_button_pressed.emit()


func _on_learn_letters_button_pressed():
	count = 0
	stage = Stages.LEARNING_LETTERS
	generate_letters_set()
	next_exercise()


func next_exercise():
	var rand = RandomNumberGenerator.new()
	var i = rand.randi_range(1, 3)
	if i==1:
		generate_next_exercise_letters_type_1()
		switch_screen(current_panel, exercise_type_1)
		current_panel = exercise_type_1
	elif i==2:
		switch_screen(current_panel, exercise_type_2)
		current_panel = exercise_type_2
	elif i==3:
		switch_screen(current_panel, exercise_type_3)
		current_panel = exercise_type_3


func _on_learn_words_button_pressed():
	pass # Replace with function body.
