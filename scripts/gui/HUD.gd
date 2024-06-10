extends CanvasLayer

@onready var equations_ui = $"equations ui"
@onready var hud_overview = $HudOverview
@onready var overview_animation_player = $HudOverview/AnimationPlayer

func _ready():
	hud_overview.visible = false

func _on_check_button_2_toggled(toggled_on):
	if toggled_on == true:
		hud_overview.visible = true
		overview_animation_player.play("overview-animation")
	else:
		overview_animation_player.play_backwards("overview-animation")
