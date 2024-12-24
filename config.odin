package flappy_bird

import rl "vendor:raylib"

// Window
WINDOW_WIDTH :: 288
WINDOW_HEIGHT :: 512
TITLE :: "Flappy Bird"
TARGET_FPS :: 60
CLEAR_COLOR :: rl.BLUE

// Status screens
START_GAME_TEXT :: "Press SPACE to start"
START_GAME_FONT_SIZE :: 24
START_GAME_FONT_COLOR :: rl.GREEN

GAME_OVER_TEXT :: "Game Over"
GAME_OVER_FONT_SIZE :: 36
GAME_OVER_FONT_COLOR :: rl.RED

// Bird
BIRD_SCALE :: 1
BIRD_SIZE_X :: 34
BIRD_SIZE_Y :: 24
BIRD_COLOR :: rl.YELLOW
BIRD_GRAVITY :: 1
BIRD_SPEED :: 20
BIRD_MAX_UP_ROTATION :: -45
BIRD_MAX_DOWN_ROTATION :: 90
BIRD_COLLIDER_OFFSET :: 5
BIRD_ANIMATION_FRAME_MS :: 100

// Pipes
PIPE_SPEED :: 10
PIPE_WIDTH :: 52
PIPE_SCALE :: 1
PIPE_GATE_HEIGHT :: WINDOW_WIDTH / 3
PIPE_COLOR :: rl.GREEN
PIPE_GENERATOR_DELAY_MS :: 2300

// Background
BKG_SCALE :: 1

// Score
SCORE_LEFT_OFFSET :: 20
SCORE_BOTTOM_OFFSET :: 20
SCORE_FONT_SIZE :: 16
SCORE_FONT_COLOR :: rl.BLACK
