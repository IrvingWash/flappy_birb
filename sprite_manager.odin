package flappy_bird

import "core:strings"
import rl "vendor:raylib"

SpriteManager :: struct {
	sprites: map[string]rl.Texture2D,
}

sm_init :: proc() -> SpriteManager {
	return SpriteManager{}
}

sm_destroy :: proc(sm: SpriteManager) {
	for _, sprite in sm.sprites {
		rl.UnloadTexture(sprite)
	}

	delete(sm.sprites)
}

sm_load_sprite :: proc(sm: ^SpriteManager, name: string, path: string) {
	using strings

	sm.sprites[name] = rl.LoadTexture(clone_to_cstring(path))
}
