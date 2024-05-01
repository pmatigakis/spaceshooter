extends CanvasLayer

var score = 0
var difficulty = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Score: %d" % score
	$Difficulty.text = "Difficulty: %d" % difficulty


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func increase_score():
	score += 1
	$Score.text = "Score: %d" % score


func increase_difficulty():
	difficulty += 1
	$Difficulty.text = "Difficulty: %d" % difficulty


func show_message(message):
	$Message.text = message
	$BackToMenu.visible = true


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Menu.tscn")
