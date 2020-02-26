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


-- GENERATE TILE TABLE
function generateTiles(atlas)
    local tiles = {}
    local sheet_width = 6;
    local sheet_height = 9;
    
    local color_counter = 1;
    
    for y = 1, sheet_height do
        local sprite_x = 0;
        for i = 1, 2 do 
            tiles[color_counter] = {}
            
            for x = 1, sheet_width do
                table.insert( tiles[color_counter], love.graphics.newQuad(sprite_x , (y - 1)* TILE_HEIGHT, 
                                                    TILE_WIDTH, TILE_HEIGHT, 
                                                    atlas:getDimensions()) );
                sprite_x = sprite_x + 32;
            end

            color_counter = color_counter + 1;
        end
    end

    return tiles;
end