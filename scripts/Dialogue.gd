extends Node


export var dialogueId = ""

var player
var parser
var diaSubtitle
var diaChoiceBox
var choiceButtonScene
var choiceButtons = []

var dia
var diaPos = 0
var dEntry = null

var dialogueOngoing = false
var condImmunities = []

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	parser = get_node("/root/GameManager/DialogueParser")
	diaSubtitle = get_node("/root/UI/CanvasLayer/Subtitles")
	diaChoiceBox = get_node("/root/UI/CanvasLayer/DialogueChoices")
	choiceButtonScene = preload("res://scenes/minor/DiaChoiceButton.tscn")
	
	if parser == null:
		print("PARSER IS NULL")
	else:
		if parser.dialogues.has(dialogueId):
			dia = parser.dialogues[dialogueId]
		else:
			print("DIALOGUE IS NULL (%s)" % dialogueId)
	
	if diaSubtitle == null:
		print("DIALOGUE UI IS NULL")
	else:
		pass
		
	if player == null:
		print("PLAYER IS NULL")

func interact():
#	print("dialogue with " + self.get_name() + " started.")
	progress()

func is_dialogue_ongoing():
	return dialogueOngoing

func progress(choice = null):
	if dia == null:
		print("error: could not progress. dia is null.")
		return
	
	if choice != null:
		parser.parse_conseq(choice.conseq, dialogueId)
	elif dEntry != null and dEntry.choices.size() > 0:
		print("You have to make a choice.")
		return  # needed to have picked a choice 
		
	dEntry = null
	var foundValidEntry = false
	while !foundValidEntry and diaPos < dia.sequence.size():
		var entry = dia.sequence[diaPos]
		
		if entry.conditions.size() > 0:
			var cond = entry.conditions[entry.conditions.size() - 1]
			if cond in condImmunities:
				foundValidEntry = true
				dEntry = entry
			
			elif parser.validate_condition(cond, dialogueId):
				condImmunities.append(cond)
				foundValidEntry = true
				dEntry = entry
		else:
			foundValidEntry = true
			dEntry = entry
		
		diaPos += 1
	
	if foundValidEntry and dEntry != null:
		dialogueOngoing = true
		player.canMove = false
		diaSubtitle.connect("pressed", self, "_on_subtitle_pressed")
		
		var text = dEntry.text
		print("text: " + text)
		
		diaSubtitle.visible = true
		diaSubtitle.text = text
		
		if dEntry.choices.size() == 0:
			diaSubtitle.disabled = false
		else:
			diaSubtitle.disabled = true
		
		for c in dEntry.choices:
			print(c.text)
			var button = choiceButtonScene.instance()
			button.text = c.text
			button.connect("pressed", self, "_on_choice_button_pressed", [c])
			diaChoiceBox.add_child(button)
			choiceButtons.append(button)
	else:
		dialogueOngoing = false
		player.canMove = true
		diaSubtitle.disconnect("pressed", self, "_on_subtitle_pressed")
		diaSubtitle.visible = false
		condImmunities = []
		diaPos = 0
		parser.dialogues[dialogueId].variables = {}
		print("No more dialogue entries")

func _on_choice_button_pressed(choice):
#	print("Choice: \"%s\"; Conseq: %s" % [choice.text, choice.conseq])
	
	for cb in choiceButtons:
		cb.remove_and_skip()
	
	progress(choice)

func _on_subtitle_pressed():
	progress()
