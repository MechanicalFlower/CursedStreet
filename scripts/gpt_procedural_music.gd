extends Node

# Set the number of notes and the length of each note
var num_notes = 8
var note_length = 0.5

# Create an array to store the notes
var notes = []

# Create an AudioStreamPlayer node as a child of the script node
var player = AudioStreamPlayer.new()


func _ready():
	# Generate a random sequence of notes
	for i in range(num_notes):
	  notes.append(randi() % 7)
	
	add_child(player)

	# Load a sample for each note and set it as the stream for the AudioStreamPlayer node
	for i in range(num_notes):
	  player.stream = load("samples/note_" + str(notes[i]) + ".ogg")
	  player.stream_index = i


func _process(delta):
	# Play the notes
	for i in range(num_notes):
		# Get the current note
		var note = notes[i]

		# Play the note using a synthesizer or a sample
		# You can use the AudioStreamPlayer node for this
		play_note(note)

		# Wait for the duration of the note
		yield(get_tree().create_timer(note_length), "timeout")


# Play a note by setting the pitch and playing the stream
func play_note(note):
  player.pitch_scale = pow(2, note / 12)
  player.play()
