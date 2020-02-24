require 'src/Dependencies';

-- LOAD FUNCTION
function love.load()

    -- SET TEXTURE RENDER
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- SET TITLE
    love.window.setTitle("Match me");

    -- SET RANDOMSEED
    math.randomseed(os.time());

    -- SET WINDOWS SCREEN
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsyn = true
    })


    -- SETUP GAME STATE MACHINE
    game_State_Machine = StateMachine{

    };
    -- SET UP KEY CHECK
    love.keyboard.keysPressed = {};
end


-- UPDATE FUNCTION
function love.update(dt)

    love.keyboard.keysPressed = {};
end


-- RENDER FUNCTION
function love.render()

end


-- RESIZE SCREEN FUNCTION
function love.resize(w, h)
    push:resize(w,h);
end


-- KEY PRESSED FUNCTION
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
end


-- CHECK KEY WAS PRESSED FUNCTION
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end
