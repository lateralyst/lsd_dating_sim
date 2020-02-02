extends Node


export var dialogueId = ""

var parser
var diaUI

var dia
var diaPos = 0

var dialogueOngoing = false

func _ready():
	parser = get_node("/root/GameManager/DialogueParser")
	diaUI = get_node("/root/UI/CanvasLayer/Subtitles")
	
	if parser == null:
		print("PARSER IS NULL")
	else:
		dia = parser.dialogues[dialogueId]
		if dia == null:
			print("DIALOGUE IS NULL (%s)" % dialogueId)
		else:
			print("Dialogue %s successfully loaded" % dialogueId)
	
	if diaUI == null:
		print("DIALOGUE UI IS NULL")

func interact():
#	print("dialogue with " + self.get_name() + " started.")
	if diaPos < dia.sequence.size():
		dialogueOngoing = true
		var text = dia.sequence[diaPos].text
		print("text: " + text)
		
		diaUI.visible = true
		diaUI.text = text
		
		diaPos += 1
	else:
		dialogueOngoing = false
		diaUI.visible = false
		print("No more dialogue things")

func is_dialogue_ongoing():
	return dialogueOngoing
