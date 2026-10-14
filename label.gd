extends Label

@onready var label: Label = $"."
@onready var timer: Timer = $Timer

var text_number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
		text_number += 1
		label.set_text(str(text_number))
