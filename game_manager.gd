extends Node

@onready var timer_mob = get_node("/root/Game/Timer")
@onready var hrate_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/HitRateOSD")
@onready var score_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/ScoreOSD")
@onready var kills_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/KillsOSD")
@onready var bullet_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/BulletOSD")

var cakes:int = 0
var donuts:int = 0

var bullets:int = 500
var score:int = 0
var kills:int = 0
var shots:int = 0
var hits:int = 0

func get_bullets() -> int:
	if bullets < 0:
		bullets = 0
	return bullets

func get_points() -> int:
	if score < 0:
		score = 0
	return score

func get_kills() -> int:
	if kills < 0:
		kills = 0
	return kills

func get_hitrate() -> float:
	if hits < 0:
		hits = 0
	if shots < 0:
		shots = 0

	var rate:float = 0
	if shots > 0:
		rate = float(int((float(hits) / float(shots)) * 10000)) / 100

	return rate

func add_bullets(rounds:int) -> void:
	if rounds > 0:
		bullets += rounds

func sub_bullets(rounds:int) -> void:
	if rounds > 0 && bullets > 0:
		bullets -= rounds
	bullet_osd.text = str(bullets)

func add_point(points:int) -> void:
	hits += 1
	if points > 0:
		score += points * 5
		if score < 0:
			score = 0

		score_osd.text = str(score)

func sub_point(points:int) -> void:
	if points > 0:
		score -= points
		if score < 0:
			score = 0

		score_osd.text = str(score)

func add_shot() -> void:
	shots += 1
	var rate:float = float(int((float(hits) / float(shots)) * 10000)) / 100
	hrate_osd.text = str(rate) + "%"

func add_cake() -> void:
	cakes += 1

func get_cakes() -> int:
	if cakes < 0:
		cakes = 0
	return cakes

func add_kill() -> void:
	var subsecs:float = 0.05
	cakes -= 1
	kills += 1
	kills_osd.text = str(kills)

	# The more we kill, the faster they spawn
	if fmod(kills, 5) == 0:
		var wait:float = timer_mob.wait_time - subsecs
		if wait < subsecs:
			wait = subsecs
		timer_mob.wait_time = wait

func add_donut() -> void:
	donuts += 1

func get_donuts() -> int:
	if donuts < 0:
		donuts = 0
	return donuts

func sub_donut() -> void:
	donuts -= 1
	if donuts < 0:
		donuts = 0
