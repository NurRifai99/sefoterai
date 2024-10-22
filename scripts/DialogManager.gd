extends Control

@onready var dialog_label = $DialogLabel  # Label for dialog text
@onready var dialog_panel = $DialogPanel# Panel or any Control for the background

func _ready() -> void: # Make the dialog elements invisible when the game starts
	##dialog_label.visible = false
	#dialog_panel.visible = false
	pass
	# Connect the click signal to the dialog box
	#dialog_panel.connect("gui_input", Callable(self, "_on_dialog_click"))

func show_dialog(dialog_text: String) -> void:
	# Show dialog text and make it visible
	dialog_label.text = dialog_text
	dialog_label.visible = true
	dialog_panel.visible = true  # Ensure the background panel is visible

func hide_dialog() -> void:
	dialog_label.visible = false
	dialog_panel.visible = false  # Hide the panel as well

# Function called when the dialog is clicked
func _on_dialog_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		hide_dialog()  # Hide the dialog when the mouse is clicked
