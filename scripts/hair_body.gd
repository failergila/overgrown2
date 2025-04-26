extends Node2D

@onready var hair_texture_rect = $HairTexture
@onready var line_drawer_parent = $LineCut
@onready var line_drawer

var hair_image : Image
var original_texture : CompressedTexture2D

func _ready():
	line_drawer = line_drawer_parent.line_drawer
	original_texture = hair_texture_rect.texture
	hair_image = original_texture.get_image()

func _process(_delta):
	if Input.is_action_just_released(""):
		cut_hair()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			pass
		else:
			cut_hair()

func cut_hair():
	for i in range(line_drawer.get_point_count() - 1):
		var from = line_drawer.get_point_position(i)
		var to = line_drawer.get_point_position(i + 1)
		erase_line(from, to)

	var new_texture = ImageTexture.create_from_image(hair_image)
	hair_texture_rect.texture = new_texture

func erase_line(from, to):
	var points = from.distance_to(to)
	for j in range(int(points)):
		var pos = from.lerp(to, j / points)
		var x = int(pos.x)
		var y = int(pos.y)

		if x >= 0 and y >= 0 and x < hair_image.get_width() and y < hair_image.get_height():
			var color = hair_image.get_pixel(x, y)
			hair_image.set_pixel(x, y, Color(color.r, color.g, color.b, 0.0))
