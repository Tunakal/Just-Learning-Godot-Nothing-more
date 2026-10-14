extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	write_inventory()


func _on_timer_timeout() -> void:
	$".".queue_free()
	
	
var inventory: Array[Dictionary] = [{"Name":"Sword","Damage":5,"Durability":10},
{"Name":"Axe","Damage": 3,"Durability": 12}]


var inventory_number = {"inventory0": 0,"inventory1": 1, "inventory2" : 2,"inventory3": 3, "inventory4": 4} 
func write_inventory():
		for inputname in inventory_number:
			if Input.is_action_just_pressed(inputname):	
				var number = inventory_number[inputname]
				if number > inventory.size():
					print("Empty Slot")
				else:	
					print("Name: ",inventory[number]["Name"])
					print("Damage: ", inventory[number]["Damage"])
					print("Durability: ",inventory[number]["Durability"])
