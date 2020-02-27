Board = Class{}

-- INIT FUNCTION
function Board:init( x, y ,level)
    self.x = x;
    self.y = y;

    self.match = {};
    self.level = level;
    self:initialized_Tiles();
    
end


-- INITIALIZED TILES
function Board:initialized_Tiles()
    self.tiles = {}
    for y = 1, 8 do 
        table.insert(self.tiles, {})
        for x = 1, 8 do 
            table.insert(self.tiles[y], Tile(x, y, math.random(1,18), math.random(self.level)));
        end
    end

    if self:findMatch() then 
        self:initialized_Tiles()
    end
end


-- DRAW BOARD
function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[1] do
            self.tiles[y][x]:render(self.x, self.y);
        end
    end
end


-- FIND MATCH
function Board:findMatch()
    -- Return list
    local matches = {};

    -- Match color number
    local match_Num = 1;

    -- Find matches on rows
    for y = 1, #self.tiles do
        
        -- Set color to the color of the first tile in row
        local color_To_Match = self.tiles[y][1].color;
        
        -- Reset match num for next row
        match_Num = 1;

        for x = 2, #self.tiles[1] do
            if self.tiles[y][x].color == color_To_Match then
                match_Num = match_Num + 1;
            else
                -- Set color to color of current tile 
                color_To_Match = self.tiles[y][x].color;

                -- If more than 3 tile of same color then add them to matches
                if match_Num >= 3 then
                    local match = {};
                    for i = x - 1, x - match_Num, -1 do
                        table.insert( match, self.tiles[y][i] )
                    end
                    table.insert(matches, match);
                end
                
                -- Reset match number
                match_Num = 1;

                -- Don't need to check last two tiles if different color
                if x >= #self.tiles[1] - 1 then 
                    break;
                end
            end
        end

        -- Check if the end of row is a match
        if match_Num >= 3 then 
            local match = {};
            for i = #self.tiles[1] , #self.tiles[1]  - match_Num + 1, -1 do
                table.insert( match, self.tiles[y][i] )
            end
            table.insert(matches, match);
        end

    end


    -- Find matches on columns
     for x = 1, #self.tiles[1] do
        
        -- Set color to the color of the first tile in row
        local color_To_Match = self.tiles[1][x].color;
        -- Reset match num for next row
        match_Num = 1;

        for y = 2, #self.tiles do
            if self.tiles[y][x].color == color_To_Match then
                match_Num = match_Num + 1;
            else
                -- Set color to color of current tile 
                color_To_Match = self.tiles[y][x].color;

                -- If more than 3 tile of same color then add them to matches
                if match_Num >= 3 then
                    local match = {};
                    for i = y - 1, y - match_Num, -1 do
                        table.insert( match, self.tiles[i][x] );
                    end
                    table.insert(matches, match);
                end

                -- Reset match number
                match_Num = 1;

                -- Don't need to check last two tiles if different color
                if y >= #self.tiles - 1 then 
                    break;
                end
            end
        end

        -- Check if the end of row is a match
        if match_Num >= 3 then 
            local match = {};
            for i = #self.tiles , #self.tiles - match_Num + 1, -1 do
                table.insert( match, self.tiles[i][x] );
            end
            table.insert(matches, match);
        end

        
    end

    self.match = matches;

    return #self.match > 0 and self.match or false;   
end

-- REMOVE EMPTY TILE
function Board:removeMatch()
    if self.match then
        for k, matches in pairs(self.match) do 
            for k, tile in pairs(matches) do 
                self.tiles[tile.grid_Y][tile.grid_X] = nil;
            end
        end
    end

    self.matches = nil;
end


-- GET FALLING TILES
function Board:getFallingTiles()
    -- Table of tween to do
    local tweens = {};

    -- CHECK EACH COLUMNS
    for x = 1, 8 do
        local space = false;
        local space_Y = 0;
        
        local y = 8;
        
        while y >= 1 do

            local tile = self.tiles[y][x];

            -- If have space 
            if space then

                -- if tile is not null then we shift it to the space Y
                if tile then
                    
                    -- shift tile to empty space
                    self.tiles[space_Y][x] = tile;
                    tile.grid_Y = space_Y;

                    -- remove old space
                    self.tiles[y][x] = nil;

                    -- tween it position
                    tweens[tile] = {
                        y = (tile.grid_Y - 1) * TILE_HEIGHT;
                    }

                    -- reset space check
                    space = false;
                    y = space_Y;
                    space_Y = 0
                end
            -- If tile if nil then we mark it as space_Y 
            elseif tile == nil then
                space = true;
                if space_Y == 0 then
                    space_Y = y;
                end
            end

            y = y - 1;
        end
    end
        
    
    -- Create new tile to replace
    for x = 1, 8 do 

        for y = 8, 1, -1 do
            local tile = self.tiles[y][x];

            if tile == nil then 
                local new_Tile = Tile(x, y, math.random(1,18), math.random(self.level))
                new_Tile.y = -32;
                self.tiles[y][x] = new_Tile;

                tweens[new_Tile] = {
                   y = (new_Tile.grid_Y - 1) * TILE_HEIGHT;
                }
            end
        end
    end

    return tweens;
end