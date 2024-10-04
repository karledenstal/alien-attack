extends Control

func set_score_label(new_score: int):
	$Score.text = "Score: " + str(new_score)

func remove_lives(amount):
	var orbs = $CanvasLayer.get_children()
	var popped = orbs.pop_at(amount)
	
	popped.hide()
