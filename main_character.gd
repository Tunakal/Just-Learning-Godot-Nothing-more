extends CharacterBody2D

enum Mode { VIEW, ADD, DROP }

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var mode := Mode.VIEW
var inventory: Array[Dictionary] = [
	{"Name": "Sword", "Damage": 5, "Durability": 10},
	{"Name": "Axe", "Damage": 3, "Durability": 12},
]
var all_item_list: Array[Dictionary] = [
	{"Name": "Sword", "Damage": 5, "Durability": 10},
	{"Name": "Axe", "Damage": 3, "Durability": 12},
	{"Name": "GreatSword", "Damage": 10, "Durability": 12},
	{"Name": "Bow", "Damage": 4, "Durability": 3},
	{"Name": "Stick", "Damage": 1, "Durability": 2},
]


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	handle_inventory()


func _on_timer_timeout() -> void:
	queue_free()


func handle_inventory() -> void:
	if Input.is_action_just_pressed("add"):
		mode = Mode.ADD
	elif Input.is_action_just_pressed("drop"):
		mode = Mode.DROP

	for i in 5:
		if not Input.is_action_just_pressed("inventory%d" % i):
			continue
		match mode:
			Mode.VIEW: print_slot(i)
			Mode.ADD: add_to_slot(i)
			Mode.DROP: drop_slot(i)
		mode = Mode.VIEW
		break


func print_slot(i: int) -> void:
	if i >= inventory.size():
		print("Empty Slot")
		return
	var item := inventory[i]
	print("Name: ", item["Name"])
	print("Damage: ", item["Damage"])
	print("Durability: ", item["Durability"])


func add_to_slot(i: int) -> void:
	var item: Dictionary = all_item_list.pick_random().duplicate()
	if i >= inventory.size():
		inventory.append(item)
	else:
		inventory[i] = item
	print("Added ", item["Name"])


func drop_slot(i: int) -> void:
	if i < inventory.size():
		print("Dropped ", inventory[i]["Name"])
		inventory.remove_at(i)
	else:
		print("Slot is already empty!")
