tool

class_name LSystem

extends Node

# a set containing elements that can be replaced
export(PoolStringArray) var variables

# a set containing elements that cannot be replaced
export(PoolStringArray) var constants

# a string defining the initial state of the system
export(String) var start

# a set defining the way elements can be replaced
export(Array, PoolStringArray) var rules


export(int, 0, 10) var iteration_limit = 1


func _ready():
	generate_sentence()


func generate_sentence(word: String = '') -> String:
	if not word:
		word = start

	for i in range(iteration_limit):
		word = grow_recursive(word)

	return word


func grow_recursive(word: String) -> String:
	var new_word := ''

	for character in word:
		new_word += process_rules_recursivelly(character)

	return new_word


func process_rules_recursivelly(character: String) -> String:
	for rule in rules:
		if rule[0] == character:
			return rule[1]
	return character
