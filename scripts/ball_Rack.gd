extends Node3D

@export var _ball_scene: PackedScene
@export var _ball_handler: BallHandler 

var _texture_library: Array[Texture] = []
var _random_indices: Array[int] = []


func _ready() -> void:
    self.position = BilliardTable.FOOT_SPOT
    _texture_library = _ball_handler.get_texture_library_duplicate()

    for i in range(_texture_library.size()):
        _random_indices.append(i)
    
    _rack_balls(5)


func _rack_balls(number_of_balls_to_rack: int) -> void:
    for ball in number_of_balls_to_rack:
        var random_int = randi_range(0, _random_indices.size())
        var random_index = _random_indices[random_int]
        _random_indices.remove_at(random_int)

        var ball_texture = _ball_handler.get_texture_by_index(random_index)

        var ball_instance = _ball_scene.instantiate() as Ball
        self.add_child(ball_instance)
        ball_instance.set_up_ball(ball_texture, BilliardTable.FOOT_SPOT * (ball * 0.5))


