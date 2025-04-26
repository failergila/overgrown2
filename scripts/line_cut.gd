extends Node2D

@onready var line_drawer = $line_drawer

var start_point_set = false
signal cutFinished

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			line_drawer.clear_points()
			line_drawer.add_point(event.position)
			line_drawer.add_point(event.position) # 2 point olacak
			start_point_set = true
		else:
			cutFinished.emit()
			start_point_set = false

	elif event is InputEventMouseMotion and start_point_set:
		line_drawer.set_point_position(1, event.position)
