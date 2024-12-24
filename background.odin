package flappy_bird

import rl "vendor:raylib"

Background :: struct {
	position: Vector2,
	scale:    f64,
}

bkg_init :: proc(window_width, window_height: uint) -> Background {
	return Background {
		position = Vector2{x = f64(window_height / 2), y = f64(window_height / 2)},
		scale = BKG_SCALE,
	}
}

bkg_draw :: proc(bkg: Background, sm: SpriteManager, window_width, window_height: uint) {
	texture := sm.sprites["bkg"]

	rl.DrawTexturePro(
		texture = texture,
		source = rl.Rectangle {
			x = 0,
			y = 0,
			width = f32(texture.width),
			height = f32(texture.height),
		},
		dest = rl.Rectangle {
			x = f32(window_width / 2),
			y = f32(window_height / 2),
			width = f32(texture.width * BKG_SCALE),
			height = f32(texture.height * BKG_SCALE),
		},
		origin = rl.Vector2 {
			f32(texture.width * BKG_SCALE / 2),
			f32(texture.height * BKG_SCALE / 2),
		},
		rotation = 0,
		tint = rl.WHITE,
	)
}
