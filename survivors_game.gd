extends Node2D

@onready var manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")
@onready var hrate_osd = get_node("/root/Game/GameOver/ColorRect/HitRateOSD")
@onready var score_osd = get_node("/root/Game/GameOver/ColorRect/ScoreOSD")
@onready var kills_osd = get_node("/root/Game/GameOver/ColorRect/KillsOSD")

const MIN_X:int = -1500
const MIN_Y:int = -1500
const MAX_X:int = 5000
const MAX_Y:int = 5000

const MAX_CAKES:int = 50
const MAX_DONUTS:int = 10

func _ready() -> void:
	generate_map()

func spawn_mob() -> void:
	var new_mob = preload("res://mob.tscn").instantiate()

	%PathFollow2D.progress_ratio = randf()
	var posX = %PathFollow2D.global_position.x
	var posY = %PathFollow2D.global_position.y
	var space = 180

	if posX <= MIN_X + (space / 2):
		posX = MIN_X + space
	if posX >= MAX_X - (space / 2):
		posX = MAX_X - space
	if posY <= MIN_Y + (space / 2):
		posY = MIN_Y + space
	if posY >= MAX_Y - (space / 2):
		posY = MAX_Y - space

	new_mob.global_position = Vector2(posX, posY)
	add_child(new_mob)
	
func spawn_tree(x:int, y:int) -> void:
	var new_tree = preload("res://pine_tree.tscn").instantiate()
	new_tree.position = Vector2(x, y)
	add_child(new_tree)

func spawn_donut() -> void:
	var new_donut = preload("res://donut.tscn").instantiate()
	var plusX:int = int(float(MAX_X - MIN_X) * randf())
	var plusY:int = int(float(MAX_Y - MIN_Y) * randf())

	new_donut.position = Vector2(MIN_X + plusX, MIN_Y + plusY)
	add_child(new_donut)

func _on_timer_timeout() -> void:
	var cakes:int = manager.get_cakes()
	if cakes <= MAX_CAKES:
		spawn_mob()
	
	var donuts:int = manager.get_donuts()
	if donuts <= MAX_DONUTS:
		spawn_donut()

func _on_player_health_depleted() -> void:
	# Set the final scores
	hrate_osd.text = str(manager.get_hitrate()) + "%"
	score_osd.text = str(manager.get_points())
	kills_osd.text = str(manager.get_kills())

	# Pause the game
	get_tree().paused = true

	# Show the End Screen
	%GameOver.visible = true

func generate_map() -> void:
	var spaceX:int = 100
	var spaceY:int = 150

	var posX:int = MIN_X
	var posY:int = MIN_Y

	# Build the surrounding "forest"
	while posX < MAX_X:
		spawn_tree(posX + (spaceX / 2), posY - (spaceY / 2))
		spawn_tree(posX + spaceX, posY)
		spawn_tree(posX, posY)
		posX += spaceX
		if posX > 100000:
			posX = MAX_X

	while posY < MAX_Y:
		spawn_tree(posX + (spaceX / 2), posY + (spaceY / 2))
		spawn_tree(posX + spaceX, posY)
		spawn_tree(posX, posY)
		posY += spaceY
		if posY > 100000:
			posY = MAX_Y

	while posX > MIN_X:
		spawn_tree(posX - (spaceX / 2), posY + (spaceY / 2))
		spawn_tree(posX, posY + spaceY)
		spawn_tree(posX, posY)
		posX -= spaceX
		if posX < -100000:
			posX = MIN_X
	
	while posY > MIN_Y:
		spawn_tree(posX + (spaceX / 2), posY + (spaceY / 2))
		spawn_tree(posX + spaceX, posY)
		spawn_tree(posX, posY)
		posY -= spaceY
		if posY < -100000:
			posY = MIN_Y

	# Position some random trees around the map
	for i in 100:
		var plusX = int((MAX_X - MIN_X) * randf())
		var plusY = int((MAX_Y - MIN_Y) * randf())
		posX = MIN_X + plusX
		posY = MIN_Y + plusY
		if plusX < 0:
			plusX = 0
		if plusY < 0:
			plusY = 0

		if posX > (MAX_X - spaceX):
			posX = MAX_X - (spaceX * 2)

		if posY > (MAX_Y - spaceY):
			posY = MAX_Y - (spaceY * 2)

		spawn_tree(posX, posY)
	
