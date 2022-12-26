extends Node

# Set the number of keyframes for the animation
const NUM_KEYFRAMES = 20

# Set the duration of the animation in seconds
const ANIMATION_DURATION = 1.0

# Set the starting position and rotation of the player's arms and hands
var initial_arm_pos = Vector3(-0.5, 0, 0)
var initial_arm_rot = Quat(0, 0, 0, 1)

# Set the ending position and rotation of the player's arms and hands
var final_arm_pos = Vector3(0.5, 0, 0)
var final_arm_rot = Quat(0, 0, 0, 1)

# Set the starting position of the mailbox
var initial_mailbox_pos = Vector3(-0.5, 0, 0)

# Set the ending position of the mailbox
var final_mailbox_pos = Vector3(0.5, 0, 0)

# Create an AnimationPlayer node to play the animation
var animation_player = AnimationPlayer.new()

func generate_keyframes():
	# Create an Animation object
	var animation = Animation.new()

	# Calculate the time interval between keyframes
	var time_interval = ANIMATION_DURATION / NUM_KEYFRAMES

	# Generate the keyframes for the player's arms and hands
	for i in range(NUM_KEYFRAMES):
		# Calculate the current time
		var time = time_interval * i

		# Calculate the position and rotation of the player's arms and hands at the current time
		var arm_pos = initial_arm_pos.lerp(final_arm_pos, time / ANIMATION_DURATION)
		var arm_rot = initial_arm_rot.slerp(final_arm_rot, time / ANIMATION_DURATION)

		# Add a track for the player's arms and hands to the animation
		animation.add_track(NodePath("player/arms"))

		# Set the keyframe for the player's arms and hands
		animation.track_set_key_value(NodePath("player/arms"), time, "translation", arm_pos)
		animation.track_set_key_value(NodePath("player/arms"), time, "rotation", arm_rot)

	# Generate the keyframes for the player's arms and hands
	for i in range(NUM_KEYFRAMES):
		# Calculate the current time
		var time = time_interval * i

		# Calculate the position and rotation of the player's arms and hands at the current time
		var arm_pos = initial_arm_pos.lerp(final_arm_pos, time / ANIMATION_DURATION)
		var arm_rot = initial_arm_rot.slerp(final_arm_rot, time / ANIMATION_DURATION)

		# Add a track for the player's arms and hands to the animation
		animation.add_track(NodePath("player/arms"))

		# Set the keyframe for the player's arms and hands
		animation.track_set_key_value(NodePath("player/arms"), time, "translation", arm_pos)
		animation.track_set_key_value(NodePath("player/arms"), time, "rotation", arm_rot)

	# Generate the keyframes for the mailbox
	for i in range(NUM_KEYFRAMES):
		# Calculate the current time
		var time = time_interval * i

		# Calculate the position of the mailbox at the current time
		var mailbox_pos = initial_mailbox_pos.lerp(final_mailbox_pos, time / ANIMATION_DURATION)

		# Add a track for the mailbox to the animation
		animation.add_track(NodePath("mailbox"))

		# Set the keyframe for the mailbox
		animation.track_set_key_value(NodePath("mailbox"), time, "translation", mailbox_pos)
