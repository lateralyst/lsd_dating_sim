extends Node

class Dialogue:
	var id = ""
	var sequence = []
	var variables = {}

class DiaEntry:
	var text = ""
	var choices = []
	var condition = ""
	
	func _init(txt):
		text = txt

class DiaChoice:
	var text = ""
	var conseq = ""

var dialogues = {}

func _ready():
	parseAllDialogues()

func parseAllDialogues():
	var path = "res://text/"
	var files = getFiles(path)
	
	for file in files:
		print("Parsing " + file + "...")
		parseDia(path, file)

	print("%s file(s) parsed." % files.size())
	printDialogues()
	pass

func parseDia(path, fileName):
	var dialogue = Dialogue.new()
	var line = null
	var id = null
	var lineNum = 0
	
	var file = File.new()
	file.open(path + fileName, File.READ)
	
	while not file.eof_reached():
		line = file.get_line()
		var originalLine = line
		lineNum += 1
		
		if line == "":
			continue
		
		if line[0] == "#":
			line.erase(0, 1)
#			print(line)
			
			var args = []
			var oldLine = line
			var b
			
			while line.length() > 1:
				b = next_block(line)
				args.append(b[0])
				line = b[1]
				
				if line == oldLine:
					break
				else:
					oldLine = line
			
			var line_type = args[0]
			
			if line_type == "start":
				if args.size() > 3:
					print("warning: too many args in line %s: " % lineNum + originalLine)
				elif args.size() < 3:
					print("critical: too few args in line %s: " % lineNum + originalLine)
					break
				
				id = args[1]
				dialogues[id] = Dialogue.new()
				
				dialogues[id].id = id
				dialogues[id].sequence.append(DiaEntry.new(args[2]))
				print("Dialogue %s sequence: %s" % [id, dialogues[id].sequence[0].text])
			
			elif line_type == "choice":
				if args.size() > 3:
					print("warning: too many args in line %s: " % lineNum + originalLine)
				elif args.size() < 3:
					print("critical: too few args in line %s: " % lineNum + originalLine)
					break
				
				var choice = DiaChoice.new()
				choice.text = args[1]
				choice.conseq = args[2]
				
				dialogues[id].sequence[dialogues[id].sequence.size() - 1].choices.append(choice)
			
			elif line_type == "cont":
				if args.size() > 2:
					print("warning: too many args in line %s: " % lineNum + originalLine)
				elif args.size() < 2:
					print("critical: too few args in line %s: " % lineNum + originalLine)
					break
				
				var entry = DiaEntry.new(args[1])
#				entry.condition = ""
				
				dialogues[id].sequence.append(entry)
			
			else:
				print("line %s could not be parsed (%s)" % [lineNum, originalLine])
	
	
	file.close()


func getFiles(path):
	var files = []
	var dir = Directory.new()
	var suffix = ".tree"
	
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(suffix):
			files.append(file)
	
	dir.list_dir_end()
	return files


func next_block(s):
	var result = ""
	s = s.lstrip(" ")
	
	if s[0] == ">": # if its a conseq
		result = s.right(1)
		result = result.lstrip(" ")
		return [result, ""]
	
	var nextquote = s.find('"')
	var secondquote = s.find('"', nextquote + 1)
	var spaceAfterNextWord = s.find(" ")
	
	if (nextquote < spaceAfterNextWord or spaceAfterNextWord == -1) and nextquote != -1: # get quoted string
		result = s.substr(nextquote + 1, secondquote - nextquote - 1)
		s.erase(0, secondquote + 1)

	else: # get string between spaces
		var end = -1
		
		# if no 2nd space is found, the end of the line is the end
		if spaceAfterNextWord == -1:
			end = s.length() - 1
		else:
			end = spaceAfterNextWord - 1  # space not included
		
		if end == -1:
			print("error: end is still -1")
		
		result = s.substr(0, end + 1)
		s.erase(0, end + 1)
	
#	print("next block = " + result)
#	print("s = " + s)
	return [result, s]

func printDialogues():
	for dia in dialogues:
		print("Dialogue %s:" % dia)
		var i = 0
		for entry in dialogues[dia].sequence:
			print("  Entry %s:\n    text: %s\n    choices:" % [i, entry.text])
			for choice in entry.choices:
				print("      %s => %s" % [choice.text, choice.conseq])
				
			# TODO: print conditions
			i += 1




