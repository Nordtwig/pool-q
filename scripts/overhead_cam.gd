extends Camera3D


func _ready() -> void:
    GameEvents.cue_ball_hit.connect(_on_cue_ball_hit)


func _on_cue_ball_hit() -> void:
    self.make_current()