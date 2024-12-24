package flappy_bird

import "core:strings"
import rl "vendor:raylib"

create_window :: proc(width, height: uint, title: string, target_fps: uint = 60) {
    using strings

    rl.SetConfigFlags({.VSYNC_HINT})

    rl.InitWindow(i32(width), i32(height), clone_to_cstring(title))

    rl.SetTargetFPS(i32(target_fps))
}

close_window :: proc() {
    rl.CloseWindow()
}
