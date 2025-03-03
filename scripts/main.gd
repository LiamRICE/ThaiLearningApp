extends Node

@onready var title_screen:CanvasLayer = $Screens
@onready var learn_screen:CanvasLayer = $LearnScreen
@onready var practice_screen:CanvasLayer = $PracticeScreen

var initialiser = InitialiseData.new()
var data_resource:DataResource

# Called when the node enters the scene tree for the first time.
func _ready():
	data_resource = initialiser.initialise()
	print(data_resource)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_screen(screen:CanvasLayer, visible:bool):
	if visible:
		screen.show()
	else:
		screen.hide()


func _on_screens__learn_button_pressed():
	# hide title screen
	update_screen(title_screen, false)
	# set data
	learn_screen.data = data_resource
	# show learn new screen
	update_screen(learn_screen, true)
	print("Learn...")


func _on_screens__practice_button_pressed():
	# hide title screen
	update_screen(title_screen, false)
	# set data
	practice_screen.data = data_resource
	# show practice screen
	update_screen(practice_screen, true)
	print("Practice...")


func _on_screens__reset_button_pressed():
	# delete the save data
	print("Deleting data...")
	initialiser.delete_save_data()
	print("Generating new data...")
	data_resource = initialiser.initialise()


func _on_learn_screen__back_button_pressed():
	# return to main screen
	update_screen(learn_screen, false)
	data_resource = learn_screen.data
	update_screen(title_screen, true)


func _on_practice_screen__back_button_pressed():
	print("Going back from practice")
	# return to main screen
	update_screen(practice_screen, false)
	data_resource = practice_screen.data
	update_screen(title_screen, true)


func trigger_save(data:DataResource):
	initialiser.data = data
	initialiser.save()
