extends CanvasLayer

@onready var learn_button = $ContentPanel/MarginContainer/MainContainer/PrimaryContainer/LearnButton
@onready var practice_button = $ContentPanel/MarginContainer/MainContainer/PrimaryContainer/PracticeButton
@onready var reset_account_button = $ContentPanel/MarginContainer/MainContainer/ResetAccountButton

signal _learn_button_pressed
signal _practice_button_pressed
signal _reset_button_pressed

func _on_learn_button_pressed():
	# go to learn screen
	_learn_button_pressed.emit()


func _on_practice_button_pressed():
	# go to practice screen
	_practice_button_pressed.emit()


func _on_reset_account_button_pressed():
	# delete save file
	_reset_button_pressed.emit()
