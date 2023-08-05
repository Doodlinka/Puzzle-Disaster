extends Node2D


const MENU_OPTIONS := 2
@export_file var game_scene : String
var selected_menu := 0 


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().root.get_child(-1) != self:
		get_tree().change_scene_to_file("res://scenes/game states/title_screen.tscn")
	change_menu_color()
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
	
				
func _input(_event):
	if Input.is_action_just_pressed("move_down"):
		selected_menu += 1
		if selected_menu > MENU_OPTIONS - 1:
			selected_menu = 0
		change_menu_color()
		
	elif Input.is_action_just_pressed("move_up"):
		selected_menu -= 1
		if selected_menu < 0:
			selected_menu = MENU_OPTIONS - 1
		change_menu_color()
		
	elif Input.is_action_just_pressed("jump"):
		match selected_menu:
			0:
				get_tree().change_scene_to_file(game_scene)
			1:
				get_tree().quit()
