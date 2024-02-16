extends Node3D

@export var _cue_ball: RigidBody3D
@export var _aim_container: Node3D


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta) -> void:
    if Input.is_action_just_pressed("shoot"):
        var impulse_vector = Vector3(1, 0, 0)
        _cue_ball.apply_central_impulse(impulse_vector)
        
    _aim_container.position = _cue_ball.position


func _input(event: InputEvent) -> void:
    var mouse_motion = event as InputEventMouseMotion
    
    if mouse_motion:
        _aim_container.rotation_degrees.y += mouse_motion.relative.x


func _handle_shot_input():
    pass