extends Node

@onready var timer_mob = get_node("/root/Game/Timer")
@onready var hrate_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/HitRateOSD")
@onready var score_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/ScoreOSD")
@onready var kills_osd = get_node("/root/Game/CanvasLayer/ColorRect/GameManager/KillsOSD")

var score:int = 0
var kills:int = 0
var cakes:int = 0
var shots:int = 0
var hits:int = 0

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
	cakes -= 1
	kills += 1
	kills_osd.text = str(kills)
	
	if fmod(kills, 5) == 0:
		timer_mob.wait_time -= 0.05
