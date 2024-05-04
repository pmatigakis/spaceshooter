extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Score: 0"
	$Difficulty.text = "Difficulty: 1"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_difficulty_changed(new_difficulty):
	$Difficulty.text = "Difficulty: %d" % new_difficulty


func _on_score_changed(new_score):
	$Score.text = "Score: %d" % new_score


func _on_player_killed():
	$Message.text = "You died!"
	$BackToMenu.visible = true
