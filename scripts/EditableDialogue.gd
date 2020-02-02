extends Node

export var dialogueStart = ""
export(PoolStringArray) var branches

func interact():
	print("dialogue with " + self.get_name() + " started.")
