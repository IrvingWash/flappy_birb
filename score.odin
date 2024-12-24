package flappy_bird

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

Score :: struct {
    value: uint,
}

score_init :: proc() -> Score {
    return Score{value = 0}
}

score_update :: proc(score: ^Score, bird: Bird, pipes: [dynamic]PipePair) {
    result: uint

    for pair in pipes {
        if pair.upper.position.x < bird.position.x {
            result += 10
        }
    }

    score.value = result
}

draw_score :: proc(score: Score, window_height: uint) {
    using strings

    rl.DrawText(
        clone_to_cstring(fmt.aprint("Score: ", score.value)),
        SCORE_LEFT_OFFSET,
        i32(window_height - SCORE_BOTTOM_OFFSET),
        SCORE_FONT_SIZE,
        SCORE_FONT_COLOR,
    )
}
