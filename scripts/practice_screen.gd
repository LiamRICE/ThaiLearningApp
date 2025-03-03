extends CanvasLayer

var data:DataResource

@onready var learn_screen = $"."

var num_exercises_in_set = 20
var num_exercises = 0

signal _back_button_pressed

@onready var learn_letters_button:Button = $PracticePanel/VBoxContainer/VBoxContainer/LearnLettersButton
@onready var learn_words_button:Button = $PracticePanel/VBoxContainer/VBoxContainer/LearnWordsButton
@onready var back_button:Button = $PracticePanel/VBoxContainer/BackButton

# Main Panel
@onready var main_panel:Panel = $PracticePanel
@onready var exercise_type_1:Panel = $LearningPanelExerciseType1
@onready var exercise_type_2:Panel = $LearningPanelExerciseType2
@onready var exercise_type_3:Panel = $LearningPanelExerciseType3
# Exercise Panels
@onready var exercise_panel_1:Panel = $LearningPanelExerciseType1
@onready var exercise_label:Label = $LearningPanelExerciseType1/VBoxContainer/VBoxContainer/ExerciseLabel
@onready var exercise_buttons:Array[Button] = [
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton1,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton2,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton3,
	$LearningPanelExerciseType1/VBoxContainer/VBoxContainer/HBoxContainer/GridContainer/OptionButton4
]
@onready var check_continue_button:Button = $LearningPanelExerciseType1/VBoxContainer/VBoxContainer/CheckContinueButton
@onready var quict_lesson_button:Button = $LearningPanelExerciseType1/VBoxContainer/QuitLessonButton

# stages
enum Stages {
	MENU = 0,
	LEARNING_LETTERS = 1,
	LEARNING_WORDS = 2
}
var stage:Stages
var current_panel:Panel
var correct_answer = -1
var given_anwser = -1

# set management
var learning_set:Array[LetterResource]


func _ready():
	num_exercises = 0
	stage = Stages.MENU
	current_panel = main_panel


func generate_letters_set() -> bool:
	learning_set = data.get_learning_letter_set(3)
	if len(learning_set) > 0:
		return true
	else:
		return false


func generate_next_exercise_letters_type_1():
	# generate the question and 4 options, including which one is the correct option
	# select letter out of the options
	var rand = RandomNumberGenerator.new()
	var i = rand.randi_range(0, len(learning_set)-1)
	var letter:LetterResource = learning_set[i]
	i = rand.randi_range(0, 1)
	# select type of the question
	var x = rand.randi_range(0, 1)
	var question_type:int
	if x == 0:
		question_type = data.LetterQuestionType.NAME
	else:
		question_type = data.LetterQuestionType.SOUND
	# get confusion letters for this exercise
	var confusion_set:Array[LetterResource] = data.get_confusion_letters_no_crossover(3, letter, question_type)
	# set visuals to the correct values and record correct button
	correct_answer = rand.randi_range(0, 3)
	print("Correct answer: ",correct_answer+1)
	var add = 0
	if question_type == data.LetterQuestionType.NAME:
		if i == 0:
			# name -> text
			exercise_label.text = letter.letter_name
			for j in range(0, len(exercise_buttons)):
				if j == correct_answer:
					print("Button ", j+1, " item id: ", j-add)
					add = 1
					exercise_buttons[j].text = letter.letter_text
				else:
					print("Button ", j+1, " item id: ", j-add)
					exercise_buttons[j].text = confusion_set[j-add].letter_text
		else:
			# text -> name
			exercise_label.text = letter.letter_text
			for j in range(0, len(exercise_buttons)):
				if j == correct_answer:
					print("Button ", j+1, " item id: ", j-add)
					add = 1
					exercise_buttons[j].text = letter.letter_name
				else:
					print("Button ", j+1, " item id: ", j-add)
					exercise_buttons[j].text = confusion_set[j-add].letter_name
	elif question_type == data.LetterQuestionType.SOUND:
		if i == 0:
			# sound -> text
			exercise_label.text = letter.letter_sound
			for j in range(0, len(exercise_buttons)):
				if j == correct_answer:
					add = 1
					exercise_buttons[j].text = letter.letter_text
				else:
					exercise_buttons[j].text = confusion_set[j-add].letter_text
		else:
			# text -> sound
			exercise_label.text = letter.letter_text
			for j in range(0, len(exercise_buttons)):
				if j == correct_answer:
					add = 1
					exercise_buttons[j].text = letter.letter_sound
				else:
					exercise_buttons[j].text = confusion_set[j-add].letter_sound


func set_color(button:Button, color:Color):
	button.add_theme_color_override("font_color", color)
	button.add_theme_color_override("font_disabled_color", color)
	button.add_theme_color_override("font_focus_color", color)
	button.add_theme_color_override("font_hover_color", color)
	button.add_theme_color_override("font_hover_pressed_color", color)
	button.add_theme_color_override("font_outline_color", color)
	button.add_theme_color_override("font_pressed_color", color)


func check_answer():
	if given_anwser == correct_answer:
		# correct answer
		set_color(exercise_buttons[correct_answer], Color.LIME_GREEN)
		set_color(check_continue_button, Color.LIME_GREEN)
	else:
		# incorrect answer
		# set correct button to green
		set_color(exercise_buttons[correct_answer], Color.LIME_GREEN)
		# set incorrect button to red
		set_color(exercise_buttons[given_anwser], Color.RED)
		set_color(check_continue_button, Color.RED)
	check_continue_button.text = "Continue ("+str(num_exercises)+"/"+str(num_exercises_in_set)+")"
	check_continue_button.show()
	# reveal continue button


func switch_screen(source:Panel, destination:Panel):
	source.hide()
	destination.show()


func _on_back_button_pressed():
	_back_button_pressed.emit()


func _on_learn_letters_button_pressed():
	num_exercises = 0
	var has_learned_letters:bool = generate_letters_set()
	if has_learned_letters:
		stage = Stages.LEARNING_LETTERS
		next_exercise()
	

func next_exercise():
	# increment number of exercises
	num_exercises += 1
	# select type of question if not enough exercises are done
	if num_exercises <= num_exercises_in_set:
		var rand = RandomNumberGenerator.new()
		var i = rand.randi_range(1, 1)
		if i==1:
			generate_next_exercise_letters_type_1()
			switch_screen(current_panel, exercise_type_1)
			current_panel = exercise_type_1
		#elif i==2:
			#switch_screen(current_panel, exercise_type_2)
			#current_panel = exercise_type_2
		#elif i==3:
			#switch_screen(current_panel, exercise_type_3)
			#current_panel = exercise_type_3
	else:
		# set letters as seen
		for letter in learning_set:
			letter.times_practiced += 1
		switch_screen(current_panel, main_panel)
		current_panel = main_panel


func _on_learn_words_button_pressed():
	pass # Replace with function body.


func _on_option_button_1_pressed():
	given_anwser = 0
	check_answer()


func _on_option_button_2_pressed():
	given_anwser = 1
	check_answer()


func _on_option_button_3_pressed():
	given_anwser = 2
	check_answer()


func _on_option_button_4_pressed():
	given_anwser = 3
	check_answer()


func _on_check_continue_button_pressed():
	check_continue_button.hide()
	# reset button colours
	set_color(check_continue_button, Color.WHITE)
	for button in exercise_buttons:
		set_color(button, Color.WHITE)
	next_exercise()


func _on_quit_lesson_button_pressed():
	num_exercises = 0
	switch_screen(current_panel, main_panel)
	current_panel = main_panel
