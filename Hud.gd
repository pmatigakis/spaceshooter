extends CanvasLayer

var score

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func increase_score():
	score += 1
	$Score.text = String(score)

func show_message(message):
	$Message.text = message
	$BackToMenu.visible = true


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Menu.tscn")
