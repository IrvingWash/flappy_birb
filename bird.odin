package flappy_bird

import rl "vendor:raylib"

Bird :: struct {
    position: Vector2,
    scale: f64,
    rotation: f64,
    velocity: Vector2,
    size: Vector2,
    speed: f64,
    color: rl.Color
}

bird_init :: proc(window_width: uint, window_height: uint) -> Bird {
    return Bird {
        position = Vector2 {
            x = f64(window_width / 4),
            y = f64(window_height / 2),
        },
        scale = BIRD_SCALE,
        rotation = 0,
        velocity = Vector2{0, 0},
        size = Vector2{
            x = BIRD_SIZE_X,
            y = BIRD_SIZE_Y,
        },
        speed = BIRD_SPEED,
        color = BIRD_COLOR,
    }
}

bird_move :: proc(bird: ^Bird, dt: f64) {
    bird.velocity.y = BIRD_GRAVITY

    if rl.IsKeyDown(rl.KeyboardKey.SPACE) {
        bird.velocity.y = -bird.speed
    }

    add_vector2_in_place(&bird.position, scale_vector2(bird.velocity, dt))
}

bird_draw :: proc(bird: Bird) {
    rl.DrawRectanglePro(
        rl.Rectangle{
            x = f32(bird.position.x),
            y = f32(bird.position.y),
            width = f32(bird.size.x * bird.scale),
            height = f32(bird.size.y * bird.scale),
        },
        rl.Vector2{
            f32(bird.size.x * bird.scale / 2),
            f32(bird.size.x * bird.scale / 2),
        },
        f32(bird.rotation),
        bird.color,
    )
}

bird_collide_with_world_edges :: proc(bird: ^Bird, window_height: uint) {
    if bird.position.y - bird.size.y / 2 <= 0 {
        bird.position.y = bird.size.y / 2
    }
}
