package flappy_bird

import "core:fmt"
import rl "vendor:raylib"

Pipe :: struct {
    position: Vector2,
    scale: f64,
    size: Vector2,
    rotation: f64,
    color: rl.Color,
}

PipePair :: struct {
    upper: Pipe,
    lower: Pipe,
    speed: f64,
    is_passed: bool,
}

PipePairGenerator :: struct {
    prev_time: f64,
    delay: f64,
}

ppg_init :: proc() -> PipePairGenerator {
    return PipePairGenerator {
        prev_time = 0,
        delay = PIPE_GENERATOR_DELAY_MS,
    }
}

ppg_generate :: proc(ppg: ^PipePairGenerator, window_width: uint, window_height: uint, time: f64) -> Maybe(PipePair) {
    if (time - ppg.prev_time) <= ppg.delay {
        return nil
    }

    ppg.prev_time = time

    size := Vector2{
        x = PIPE_WIDTH,
        y = f64(window_height - PIPE_GATE_HEIGHT) / 2
    }

    upper := Pipe {
        position = Vector2{
            x = f64(window_width),
            y = size.y / 2,
        },
        scale = PIPE_SCALE,
        size = size,
        rotation = 180,
        color = PIPE_COLOR,
    }

    lower := Pipe {
        position = Vector2{
            x = f64(window_width),
            y = (f64(window_height) - size.y / 2),
        },
        scale = PIPE_SCALE,
        size = size,
        rotation = 0,
        color = rl.RED,
    }

    return PipePair{
        upper = upper,
        lower = lower,
        speed = PIPE_SPEED,
        is_passed = false,
    }
}

pipe_pair_move :: proc(pipe_pair: ^PipePair, dt: f64) {
    pipe_pair.upper.position.x -= pipe_pair.speed * dt
    pipe_pair.lower.position.x -= pipe_pair.speed * dt
}

pipe_pair_draw :: proc(pipe_pair: PipePair) {
    using pipe_pair

    rl.DrawRectanglePro(
        rec = rl.Rectangle{
            x = f32(upper.position.x),
            y = f32(upper.position.y),
            width = f32(upper.size.x * upper.scale),
            height = f32(upper.size.y * upper.scale),
        },
        origin = rl.Vector2{
            f32(upper.size.x * upper.scale / 2),
            f32(upper.size.y * upper.scale / 2),
        },
        rotation = f32(upper.rotation),
        color = upper.color,
    )

    rl.DrawRectanglePro(
        rec = rl.Rectangle{
            x = f32(lower.position.x),
            y = f32(lower.position.y),
            width = f32(lower.size.x * lower.scale),
            height = f32(lower.size.y * lower.scale),
        },
        origin = rl.Vector2{
            f32(lower.size.x * lower.scale / 2),
            f32(lower.size.y * lower.scale / 2),
        },
        rotation = f32(lower.rotation),
        color = lower.color,
    )
}
