class_name Train

extends Spatial

var _timer = null

onready var tween: Tween = get_node("TrainTween")


func _init():
	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = 60
	_timer.connect("timeout", self, "move")

func _ready():
	move()


func move():
	# TODO : faire une gare et faire arreter le train dans celle ci, puis le faire repartir
	tween.interpolate_property(
		self,
		"translation:z",
		-100, 150, 20
	)
	tween.start()
	_timer.start()
