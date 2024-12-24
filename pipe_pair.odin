package flappy_bird

import "core:math/rand"
import rl "vendor:raylib"

Pipe :: struct {
	position: Vector2,
	scale:    f64,
	size:     Vector2,
	rotation: f64,
	color:    rl.Color,
}

PipePair :: struct {
	upper:     Pipe,
	lower:     Pipe,
	speed:     f64,
	is_passed: bool,
}

PipePairGenerator :: struct {
	prev_time: f64,
	delay:     f64,
}

ppg_init :: proc() -> PipePairGenerator {
	return PipePairGenerator{prev_time = 0, delay = PIPE_GENERATOR_DELAY_MS}
}

ppg_generate :: proc(
	ppg: ^PipePairGenerator,
	window_width: uint,
	window_height: uint,
	time: f64,
) -> Maybe(PipePair) {
	if (time - ppg.prev_time) <= ppg.delay {
		return nil
	}

	ppg.prev_time = time

	upper_height := rand.float64_range(0, f64(window_height - PIPE_GATE_HEIGHT))

	upper := Pipe {
		position = Vector2{x = f64(window_width), y = upper_height / 2},
		scale = PIPE_SCALE,
		size = Vector2{
			x = PIPE_WIDTH,
			y = upper_height,
		},
		rotation = 180,
		color = PIPE_COLOR,
	}

	lower_height: = f64(window_height - PIPE_GATE_HEIGHT) - upper_height

	lower := Pipe {
		position = Vector2{x = f64(window_width), y = f64(window_height) - lower_height / 2},
		scale = PIPE_SCALE,
		size = Vector2{
			x = PIPE_WIDTH,
			y = lower_height,
		},
		rotation = 0,
		color = rl.RED,
	}

	return PipePair{upper = upper, lower = lower, speed = PIPE_SPEED, is_passed = false}
}

pipe_pair_move :: proc(pipe_pair: ^PipePair, dt: f64) {
	pipe_pair.upper.position.x -= pipe_pair.speed * dt
	pipe_pair.lower.position.x -= pipe_pair.speed * dt
}

pipe_pair_draw :: proc(pipe_pair: PipePair, sm: SpriteManager) {
	using pipe_pair

	sprite := sm.sprites["pipe"]

	rl.DrawTexturePro(
		texture = sprite,
		source = rl.Rectangle{
			x = 0,
			y = 0,
			width = f32(sprite.width),
			height = f32(sprite.height),
		},
		dest = rl.Rectangle{
			x = f32(upper.position.x),
			y = f32(upper.position.y),
			width = f32(upper.size.x),
			height = f32(upper.size.y),
		},
		origin = rl.Vector2{
			f32(upper.size.x * PIPE_SCALE / 2),
			f32(upper.size.y * PIPE_SCALE / 2),
		},
		rotation = 180,
		tint = rl.WHITE,
	)

	rl.DrawTexturePro(
		texture = sprite,
		source = rl.Rectangle{
			x = 0,
			y = 0,
			width = f32(sprite.width),
			height = f32(sprite.height),
		},
		dest = rl.Rectangle{
			x = f32(lower.position.x),
			y = f32(lower.position.y),
			width = f32(lower.size.x),
			height = f32(lower.size.y),
		},
		origin = rl.Vector2{
			f32(lower.size.x * PIPE_SCALE / 2),
			f32(lower.size.y * PIPE_SCALE / 2),
		},
		rotation = 0,
		tint = rl.WHITE,
	)
}
