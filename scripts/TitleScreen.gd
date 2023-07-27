extends Node2D

var selected_menu = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Title2/Title/AnimationPlayer.play("Start-screen")
	await $Title2/Title/AnimationPlayer.animation_finished
	$Title2/Title/AnimationPlayer.play("Loaded-screen")

func change_menu_color():
		$PlayButton/PlayRect.color = Color8(191,96,254,255)
		$QuitButton/QuitRect.color = Color8(191,96,254,255)

		match selected_menu:
			0: 
				$PlayButton/PlayRect.color = Color.LIGHT_BLUE
			1: 
				$QuitButton/QuitRect.color = Color.LIGHT_BLUE
				
func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 2;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 1:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 1
		change_menu_color()
		
	elif Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				get_tree().change_scene_to_file("res://scenes/game.tscn")
			1:
				get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
