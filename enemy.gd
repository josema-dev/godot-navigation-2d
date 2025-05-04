extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@export var speed: int = 12
@export var tileMap: TileMapLayer
var velocity_target: Vector2

func _ready() -> void:
	navigation_agent_2d.target_position = global_position

func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		navigation_agent_2d.target_position = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	if not navigation_agent_2d.is_target_reached():
		velocity_target = get_local_navigation_direction() * speed
		navigation_agent_2d.velocity = velocity_target

func _on_navigation_agent_2d_velocity_computed(safe_velocit: Vector2) -> void:
	velocity = safe_velocit
	move_and_slide()


func get_local_navigation_direction() -> Vector2:
	var destination = navigation_agent_2d.get_next_path_position()
	var local_destination = destination - global_position
	return local_destination.normalized()
