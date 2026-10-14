extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
@onready var sprite_2d: Sprite2D = $Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var redcolor = randf_range(0, 1.0)
	var greencolor = randf_range(0, 1)
	var bluecolor = randf_range(0, 1)
	sprite_2d.modulate = Color(redcolor, greencolor, bluecolor)
	
	
