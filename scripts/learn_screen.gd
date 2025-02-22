extends CanvasLayer

var data:DataResource

var count = 0

signal _back_button_pressed

@onready var learn_letters_button = $LearningPanel/VBoxContainer/VBoxContainer/LearnLettersButton
@onready var learn_words_button = $LearningPanel/VBoxContainer/VBoxContainer/LearnWordsButton
@onready var back_button = $LearningPanel/VBoxContainer/BackButton

# Panels
@onready var main_panel = $LearningPanel
@onready var exercise_type_1 = $LearningPanelExerciseType1
@onready var exercise_type_2 = $LearningPanelExerciseType2
@onready var exercise_type_3 = $LearningPanelExerciseType3


func _ready():
	count = 0


func switch_screen(source:Panel, destination:Panel):
	source.hide()
	destination.show()


func _on_back_button_pressed():
	_back_button_pressed.emit()


func _on_learn_letters_button_pressed():
	count = 0
	var rand = RandomNumberGenerator.new()
	var i = rand.randi_range(1, 3)
	if i==1:
		switch_screen(main_panel, exercise_type_1)
	elif i==2:
		switch_screen(main_panel, exercise_type_2)
	elif i==3:
		switch_screen(main_panel, exercise_type_3)


func _on_learn_words_button_pressed():
	pass # Replace with function body.
