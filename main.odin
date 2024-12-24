package flappy_bird

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
    create_window(WINDOW_WIDTH, WINDOW_HEIGHT, TITLE, TARGET_FPS)

    play()

    close_window()
}

play :: proc() {
    bird := start()

    for !rl.WindowShouldClose() {
        dt := f64(rl.GetFrameTime() * 10)

        fmt.println(bird)

        update(&bird, dt)
        render(bird)
    }
}

start :: proc() -> (Bird) {
    window_width := uint(rl.GetScreenWidth())
    window_height := uint(rl.GetScreenHeight())

    bird := bird_init(window_width, window_height)

    return bird
}

update :: proc(bird: ^Bird, dt: f64) {
    bird_move(bird, dt)
}

render :: proc(bird: Bird) {
    rl.BeginDrawing()
    rl.ClearBackground(CLEAR_COLOR)

    bird_draw(bird)

    rl.EndDrawing()
}
