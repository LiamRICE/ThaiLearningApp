GDPC                �	                                                                         X   res://.godot/exported/133200997/export-17dd6e9f64e18c10d16cb81cdb1b0361-base_theme.res          �      �-�&uEb��bd�    P   res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn�C      �      =WwB9Oe��r��Ԭ    X   res://.godot/exported/133200997/export-4aeda347a84b21fa99a0439861f0fbca-learn_screen.scn4      �      �r'$]U�D}�ޒ@�    \   res://.godot/exported/133200997/export-613620ab62f66806386b89c251281820-practice_screen.scn pI      �      �b�Ɗ��,��=eA?    X   res://.godot/exported/133200997/export-d65da3654041f192b8ec953f12f530f6-main_theme.res  �      7      I��U1P�����    T   res://.godot/exported/133200997/export-f4dd2558d8e192684fbae2f0a4360311-screens.scn @X      U      �pc����Y0����    \   res://.godot/exported/133200997/export-fae5b75535b948bd398ae02038717602-exercise_theme.res  �      �      �U�9>ж�*�rf���    ,   res://.godot/global_script_class_cache.cfg  `�      -      T�ʳ�
�M���bU�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexp�            ：Qt�E�cO���       res://.godot/uid_cache.bin  P�      8      ���?��'����X��    $   res://assets/base_theme.tres.remap  P�      g       ~M�-:Ȩw��2[��    (   res://assets/exercise_theme.tres.remap  ��      k       cs��:����er'��    $   res://assets/main_theme.tres.remap  0�      g       ��BF��j�@^��v       res://icon.svg  ��      �      k����X3Y���f       res://icon.svg.import   ��      �       �0��v�ZM/�mJ2w        res://project.binary��      �      ;�2�@ϚDlf:�4        res://resources/data_resource.gd�      L      u�ה��gi\#cj��    $   res://resources/initialise_data.gd        �      e��`��n��އ��    $   res://resources/letter_resource.gd  �0      @      ��E6!���u��y        res://resources/word_resource.gd�2      -      �]�
`�+�iN�S��    $   res://scenes/learn_screen.tscn.remap��      i       bw�-�Q����V[F�       res://scenes/main.tscn.remap�      a       
��������S8z�s    (   res://scenes/practice_screen.tscn.remap ��      l       ���OC���4��}`�        res://scenes/screens.tscn.remap �      d       {|�uD9�	�����        res://scripts/learn_screen.gd   �`      �      ���	s�ЋU����?]       res://scripts/main.gd   �|      �      =�������ŔFb���$        res://scripts/practice_screen.gd��      #      ��)oZln���-����       res://scripts/screens.gd��      �      �Ф����Ye �T��    RSRC                    Theme            ��������                                            &      resource_local_to_scene    resource_name 
   fallbacks    font_names    font_italic    font_weight    font_stretch    antialiasing    generate_mipmaps    allow_system_fallback    force_autohinter    hinting    subpixel_positioning #   multichannel_signed_distance_field    msdf_pixel_range 
   msdf_size    oversampling    script    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    default_base_scale    default_font    default_font_size    Button/constants/h_separation    Button/font_sizes/font_size    Label/colors/font_color     Label/colors/font_outline_color    Label/colors/font_shadow_color    Label/constants/line_spacing    Label/constants/outline_size     Label/constants/shadow_offset_x     Label/constants/shadow_offset_y $   Label/constants/shadow_outline_size    Label/font_sizes/font_size    Label/styles/normal    TextEdit/font_sizes/font_size           local://SystemFont_6lk1h �         local://StyleBoxEmpty_ga6ms �         local://Theme_wh6ug �         SystemFont             StyleBoxEmpty             Theme             @                                     $           �?  �?  �?  �?        �?  �?  �?  �?                                                   !         "         #      0   $            %               RSRC          RSRC                    Theme            ��������                                            	      resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    Button/constants/h_separation    Button/constants/outline_size    Button/font_sizes/font_size    script           local://Theme_vaonm i         Theme          
                  @         RSRC         RSRC                    Theme            ��������                                                  resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    script           local://Theme_8rhbg          Theme             @                RSRC         extends Resource
class_name DataResource

enum LetterQuestionType {
	NAME=0,
	SOUND=1
}

@export var letters:Array[LetterResource] = []
@export var words:Array[WordResource] = []

# Get for learning letters
func get_letter_set(num_letters:int=3, seen:bool=false) -> Array[LetterResource]:
	var return_list:Array[LetterResource] = []
	var lowest_priority = 1000
	var lowest_priority_count = 0
	var total_unseen = 0
	for letter in letters:
		# check counts for all types
		if not letter.is_seen:
			total_unseen += 1
			if letter.priority < lowest_priority:
				lowest_priority = letter.priority
				lowest_priority_count = 1
			elif letter.priority == lowest_priority:
				lowest_priority_count += 1
	if total_unseen < num_letters:
		# return only the unseen letters
		for letter in letters:
			if not letter.is_seen:
				return_list.append(letter)
	else:
		var added = 0
		while added < num_letters:
			# continue until added the correct number of letters
			for letter in letters:
				if added < num_letters and not letter.is_seen and letter.priority == lowest_priority:
					# add if the letter is not seen, has the lowest priority and if there are not enough letters added
					added += 1
					return_list.append(letter)
			lowest_priority += 1
	return return_list


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
    extends Node
class_name InitialiseData

var save_path := "user://player_data.tres" 
var data:DataResource

func initialise():
	var loaded_data = check_save()
	if not loaded_data:
		data = DataResource.new()
		print("Data initialised")
		initialise_data()
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
	ResourceSaver.save(data, save_path)


func check_save() -> Resource:
	print("Checking save...")
	var loaded_data = ResourceLoader.load(save_path)
	print("Loaded data :", loaded_data)
	return loaded_data


func delete_save_data():
	# delete file path
	DirAccess.remove_absolute(save_path)
	# empty resource
	data = null


func initialise_data():
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
	
       extends Resource
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
extends Resource
class_name WordResource

@export var word_thai:String = ""
@export var word_english:String = ""
@export var word_romanisation:String = ""
@export var word_letters:Array[LetterResource] = []
@export var is_seen:bool = false
@export var times_practiced:int = 0
@export var priority = 0
   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/learn_screen.gd ��������   Theme    res://assets/base_theme.tres .D��b�h   Theme !   res://assets/exercise_theme.tres ����ׇ      local://PackedScene_1n1cd          PackedScene          	         names "   7      LearnScreen    script    CanvasLayer    LearningPanel    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    size_flags_vertical    theme    Panel    VBoxContainer    layout_mode $   theme_override_constants/separation 
   alignment    TableTitle    custom_minimum_size $   theme_override_font_sizes/font_size    text    horizontal_alignment    vertical_alignment    Label    LearnLettersButton &   theme_override_constants/h_separation    Button    LearnWordsButton    BackButton    LearningPanelExerciseType1    visible    TitleLabel    ExerciseLabel    HBoxContainer    GridContainer &   theme_override_constants/v_separation    columns    OptionButton1    OptionButton2    OptionButton3    OptionButton4    CheckContinueButton    QuitLessonButton    LearningPanelExerciseType2    LearningPanelExerciseType3 !   _on_learn_letters_button_pressed    pressed    _on_learn_words_button_pressed    _on_back_button_pressed    _on_option_button_1_pressed    _on_option_button_2_pressed    _on_option_button_3_pressed    _on_option_button_4_pressed "   _on_check_continue_button_pressed    _on_quit_lesson_button_pressed    	   variants                            �?                              d   
         HC   0         Learn             Learn New Letters    &   Learn New Words
(not implemented yet)       Back           	   Exercise    2      h      	   Question          
     �C  HC      Option1       Option2       Option3       Option4       Next Question       Quit       node_count             nodes     s  ��������       ����                            ����                                 	      
                             ����                                                                    ����                          ����                  	      
                                ����         	      
                                   ����         	      
                             ����         	      
                              ����                                                              ����                                                       	             ����                               	             ����                                       ����                                            !   !   ����                          "   "   ����                     #      $                    %   ����                                   &   ����                                   '   ����                                   (   ����                                   )   ����               	      
         	             	          *   ����         	      
                           +   ����                                                      ,   ����                                                 conn_count    	         conns     ?          .   -                     .   /                     .   0                     .   1                     .   2                     .   3                     .   4                     .   5                     .   6                    node_paths              editable_instances              version             RSRC               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/main.gd ��������   PackedScene    res://scenes/screens.tscn �X��Ur�g   PackedScene    res://scenes/learn_screen.tscn �K����   PackedScene "   res://scenes/practice_screen.tscn ����ak      local://PackedScene_885wk �         PackedScene          	         names "         Main    script    Node    Screens    LearnScreen    visible    PracticeScreen "   _on_screens__learn_button_pressed    _learn_button_pressed %   _on_screens__practice_button_pressed    _practice_button_pressed "   _on_screens__reset_button_pressed    _reset_button_pressed &   _on_learn_screen__back_button_pressed    _back_button_pressed )   _on_practice_screen__back_button_pressed    	   variants                                                         node_count             nodes     "   ��������       ����                      ���                      ���                           ���                         conn_count             conns     #                                  
   	                                                                                            node_paths              editable_instances              version             RSRC       RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script !   res://scripts/practice_screen.gd ��������   Theme    res://assets/base_theme.tres .D��b�h   Theme !   res://assets/exercise_theme.tres ����ׇ      local://PackedScene_axhwj �         PackedScene          	         names "   5      PracticeScreen    script    CanvasLayer    PracticePanel    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    theme    Panel    VBoxContainer    layout_mode $   theme_override_constants/separation 
   alignment    TableTitle    custom_minimum_size $   theme_override_font_sizes/font_size    text    horizontal_alignment    vertical_alignment    Label    LearnLettersButton    size_flags_horizontal    size_flags_vertical &   theme_override_constants/h_separation    Button    LearnWordsButton    BackButton    LearningPanelExerciseType1    visible    TitleLabel    ExerciseLabel    HBoxContainer    GridContainer &   theme_override_constants/v_separation    columns    OptionButton1    OptionButton2    OptionButton3    OptionButton4    CheckContinueButton    QuitLessonButton !   _on_learn_letters_button_pressed    pressed    _on_learn_words_button_pressed    _on_back_button_pressed    _on_option_button_1_pressed    _on_option_button_2_pressed    _on_option_button_3_pressed    _on_option_button_4_pressed "   _on_check_continue_button_pressed    _on_quit_lesson_button_pressed    	   variants                            �?                        d   
         HC   0      	   Practice                   Practice Letters    %   Practice Words
(not implemented yet)       Back           	   Exercise             2      h      	   Question 
     �C  HC      Option1       Option2       Option3       Option4       Next Question       Quit       node_count             nodes     K  ��������       ����                      
      ����                                 	                       ����                                                                    ����                          ����                        	                                ����            
      
                                ����            
      
                          ����            
      
                     
      ����                                       	                       ����                                                       	             ����                               	             ����         	                                    ����                                            !   !   ����                          "   "   ����         	            #      $                    %   ����                                   &   ����                                   '   ����                                   (   ����                                   )   ����                  
      
                   	          *   ����            
      
                   conn_count    	         conns     ?          ,   +                     ,   -                     ,   .                     ,   /                     ,   0                     ,   1                     ,   2                     ,   3                     ,   4                    node_paths              editable_instances              version             RSRC      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/screens.gd ��������   Theme    res://assets/base_theme.tres .D��b�h   Theme    res://assets/main_theme.tres ���n�>�K      local://PackedScene_adx17 v         PackedScene          	         names "          Screens    script    CanvasLayer    ContentPanel    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    size_flags_vertical    theme    Panel    MarginContainer    layout_mode    MainContainer $   theme_override_constants/separation 
   alignment    VBoxContainer    PrimaryContainer    Title $   theme_override_font_sizes/font_size    text    Label    LearnButton    Button    PracticeButton    ResetAccountButton    _on_learn_button_pressed    pressed    _on_practice_button_pressed !   _on_reset_account_button_pressed    	   variants                            �?                              d      2             *         Thai Learning App                Learn New Letters    	   Practice       Reset Account       node_count    	         nodes     �   ��������       ����                            ����                                 	      
                             ����                                                        ����                                      ����         	      
                             ����         	      
   	      
                          ����         	      
                                   ����         	      
                                   ����         	      
                            conn_count             conns                                                                                      node_paths              editable_instances              version             RSRC           extends CanvasLayer

var data:DataResource

@onready var learn_screen = $"."

var num_exercises_in_set = 20
var num_exercises = 0

signal _back_button_pressed

@onready var learn_letters_button:Button = $LearningPanel/VBoxContainer/VBoxContainer/LearnLettersButton
@onready var learn_words_button:Button = $LearningPanel/VBoxContainer/VBoxContainer/LearnWordsButton
@onready var back_button:Button = $LearningPanel/VBoxContainer/BackButton

# Main Panel
@onready var main_panel:Panel = $LearningPanel
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


func generate_letters_set():
	learning_set = data.get_letter_set(3, false)


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
	stage = Stages.LEARNING_LETTERS
	generate_letters_set()
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
			letter.is_seen = true
		# save learning state
		var manager = $".".get_parent()
		manager.trigger_save(data)
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
               extends Node

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
 extends CanvasLayer

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
             extends CanvasLayer

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
          GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://sojangctplrn"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 [remap]

path="res://.godot/exported/133200997/export-17dd6e9f64e18c10d16cb81cdb1b0361-base_theme.res"
         [remap]

path="res://.godot/exported/133200997/export-fae5b75535b948bd398ae02038717602-exercise_theme.res"
     [remap]

path="res://.godot/exported/133200997/export-d65da3654041f192b8ec953f12f530f6-main_theme.res"
         [remap]

path="res://.godot/exported/133200997/export-4aeda347a84b21fa99a0439861f0fbca-learn_screen.scn"
       [remap]

path="res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn"
               [remap]

path="res://.godot/exported/133200997/export-613620ab62f66806386b89c251281820-practice_screen.scn"
    [remap]

path="res://.godot/exported/133200997/export-f4dd2558d8e192684fbae2f0a4360311-screens.scn"
            list=Array[Dictionary]([{
"base": &"Resource",
"class": &"DataResource",
"icon": "",
"language": &"GDScript",
"path": "res://resources/data_resource.gd"
}, {
"base": &"Node",
"class": &"InitialiseData",
"icon": "",
"language": &"GDScript",
"path": "res://resources/initialise_data.gd"
}, {
"base": &"Resource",
"class": &"LetterResource",
"icon": "",
"language": &"GDScript",
"path": "res://resources/letter_resource.gd"
}, {
"base": &"Resource",
"class": &"WordResource",
"icon": "",
"language": &"GDScript",
"path": "res://resources/word_resource.gd"
}])
   <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              .D��b�h   res://assets/base_theme.tres����ׇ    res://assets/exercise_theme.tres���n�>�K   res://assets/main_theme.tres�K����   res://scenes/learn_screen.tscn�f�N2   res://scenes/main.tscn����ak!   res://scenes/practice_screen.tscn�X��Ur�g   res://scenes/screens.tscnc�Q�   res://icon.svg        ECFG      application/config/name         Thai Learning App      application/run/main_scene          res://scenes/main.tscn     application/config/features   "         4.2    Mobile     application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      �  #   rendering/renderer/rendering_method         mobile  4   rendering/textures/vram_compression/import_etc2_astc          