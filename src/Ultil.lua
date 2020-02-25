-- FUNCTION TO GENERATE QUAD BASED ON ALTAS, TILE WIDTH, TILE HEIGHT
function generateQuad(atlas, tile_width, tile_height)
    local sprites = {};
    local sprite_counter = 1;

    local sheet_width = atlas:getWidth() / tile_width;
    local sheet_height = atlas:getHeight() / tile_height;

    for y = 0, sheet_height - 1 do
        for x = 0, sheet_width -1 do 
            sprites[sprite_counter] = love.graphics.newQuad(x* tile_width, y* tile_height, 
                                                    tile_width, tile_height, 
                                                    atlas:getDimensions());
            sprite_counter = sprite_counter + 1
        end
    end

    return sprites
end


-- SLICE FUNCTION LIKE IN PYTHON
function table.slice(tbl, start, stop, step)
    local sliced = {};

    for i = start or 1, stop or #tbl - 1, step or 1 do
        sliced[#sliced + step] = tbl[i]
    end
    
    return sliced
end


-- FUNCTION TO GET PADDLE SPRITES
function generatePaddles(atlas)
    local y = 64;
    local x = 0;
    local counter = 1;

    local quads = {}

    for i = 1, NUM_OF_PADDLE do 
        -- small paddle
        quads[counter] = love.graphics.newQuad(x, y, 
                                        SMALL_PADDLE_WIDTH, PADDLE_HEIGHT, atlas:getDimensions());
        counter = counter + 1;

        -- medium paddle
        quads[counter] = love.graphics.newQuad(x + SMALL_PADDLE_WIDTH, y, 
                                        MEDIUM_PADDLE_WIDTH, PADDLE_HEIGHT, atlas:getDimensions());
        counter = counter + 1;

        -- large paddle
        quads[counter] = love.graphics.newQuad(x + SMALL_PADDLE_WIDTH + MEDIUM_PADDLE_WIDTH, y, 
                                        LARGE_PADDLE_WIDTH, PADDLE_HEIGHT, atlas:getDimensions());
        counter = counter + 1;

        -- mega paddle
        quads[counter] = love.graphics.newQuad(x, y + PADDLE_HEIGHT,
                                        MEGA_PADDLE_WIDTH, PADDLE_HEIGHT, atlas:getDimensions());
        counter = counter + 1;

        y  = y + PADDLE_HEIGHT * 2;
    end
    return quads;
end


-- FUNCTION TO CROP THE BALLS AND RETURN THEM
function generateBalls(atlas)
    local quad = {}
    local counter = 1;

    local x = 3 * SMALL_PADDLE_WIDTH;
    local y = 3 * PADDLE_HEIGHT;

    -- Gets balls on the first row
    for i = 0, 3 do
        quad[counter] = love.graphics.newQuad(x + i*BALL_WIDTH, y, BALL_WIDTH, BALL_HEIGHT, atlas:getDimensions());
        counter = counter + 1;
    end

    -- Gets balls on the second row
    for i = 0, 2 do
        quad[counter] = love.graphics.newQuad(x + i*BALL_WIDTH, y + BALL_HEIGHT, BALL_WIDTH, BALL_HEIGHT, atlas:getDimensions());
        counter = counter + 1;
    end

    return quad;
end


-- CROP BRICKS FROM SPRITE SHEET
function generateBricks(atlas)
    return table.slice(generateQuad(atlas, BRICK_WIDTH, BRICK_HEIGHT), 1, 21, 1);
end

-- CROP HEARTS
function generateHearts(atlas)
    return generateQuad(atlas, HEART_WIDTH, HEART_HEIGHT)
end