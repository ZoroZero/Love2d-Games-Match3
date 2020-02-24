-- WINDOW DIMENSIONS
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- VIRTUAL DIMENSIONS
VIRTUAL_WIDTH = 512;
VIRTUAL_HEIGHT = 288;

-- SOUND
game_Sounds = {
    ['clock'] = love.audio.newSource('assets/sounds/clock.wav', 'static'),
    ['error'] = love.audio.newSource('assets/sounds/error.wav', 'static'),
    ['game-over'] = love.audio.newSource('assets/sounds/game-over.wav', 'static'),
    ['match'] = love.audio.newSource('assets/sounds/match.wav', 'static'),
    ['music'] = love.audio.newSource('assets/sounds/music.mp3', 'static'),
    ['music2'] = love.audio.newSource('assets/sounds/music2.mp3', 'static'),
    ['music3'] = love.audio.newSource('assets/sounds/music3.mp3', 'static'),
    ['next-level'] = love.audio.newSource('assets/sounds/next-level.wav', 'static'),
    ['select'] = love.audio.newSource('assets/sounds/select.wav', 'static'),
}

-- FONT
game_Fonts = {
    ['smallFont'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['largeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 24),
    ['hugeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 30),
}

-- TEXTURE
game_Texture = {
    ['background'] = love.graphics.newImage('assets/graphics/background.png'),
    ['main'] = love.graphics.newImage('assets/graphics/match3.png')
}