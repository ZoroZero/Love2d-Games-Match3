PlayState = Class {__includes = BaseState}

function PlayState:init()
    -- Current highlighting tile
    self.highlighting_X = 1;
    self.highlighting_Y = 1;

    -- Higlighted tile
    self.highlighted = false;
    self.highlighted_Tile = nil;

    -- Count down timer
    self.countdown = 0;
    Timer.every(1, function()
        self.countdown = self.countdown + 1;
    end    
    );

    -- User input is lock when a match is happen
    self.user_Input = true;
end

-- ENTER FUNCTION
function PlayState:enter(params)
    self.level = params.level;
    self.board = params.board;
    self.timer = params.timer;
    self.score = params.score + 400;
    self.goal = self.level * 500;

    game_Sounds['music2']:play();
    game_Sounds['music2']:setLooping(true);

end

-- UPDATE FUNCTION
function PlayState:update(dt)
    -- If less than 5s
    if self.timer - self.countdown <= 5 then 
        game_Sounds['clock']:play()
    end

    -- If out of time
    if self.timer - self.countdown <= 0 then
        Timer.clear();
        game_Sounds['game-over']:play();
        game_Sounds['music2']:stop();
        game_State_Machine:change('game_over', {score = self.score});
    
    -- If pass goal score
    elseif self.score >= self.goal then
        game_Sounds['next-level']:play();
        game_State_Machine:change('begin_game', {
                                                level = self.level + 1,
                                                score = self.score})
    end

    -- Check user input
    if self.user_Input then 
        if love.keyboard.wasPressed('left') then
            self.highlighting_X = self.highlighting_X == 1 and #self.board.tiles or self.highlighting_X - 1;
        elseif love.keyboard.wasPressed('right') then
            self.highlighting_X = self.highlighting_X == #self.board.tiles and 1 or self.highlighting_X + 1;
        end

        if love.keyboard.wasPressed('up') then
            self.highlighting_Y = self.highlighting_Y == 1 and #self.board.tiles[1] or self.highlighting_Y - 1;
        elseif love.keyboard.wasPressed('down') then
            self.highlighting_Y = self.highlighting_Y == #self.board.tiles[1] and 1 or self.highlighting_Y + 1;
        end

        if love.mouse.wasPressed(1) then 
            self.highlighting_X = math.floor((love.mouse.getX()/WINDOW_WIDTH * VIRTUAL_WIDTH - self.board.x)/32) + 1;
            self.highlighting_Y =  math.floor((love.mouse.getY()/ WINDOW_HEIGHT * VIRTUAL_HEIGHT - self.board.y)/32) + 1;

            if not self.highlighted then 
                self.highlighted = true;
                self.highlighted_Tile = self.board.tiles[self.highlighting_Y][self.highlighting_X];
            else
                -- If highlighting tile is already highlighted
                if self.highlighted_Tile.grid_X == self.highlighting_X and self.highlighted_Tile.grid_Y == self.highlighting_Y then
                    self.highlighted = false;
                    self.highlighted_Tile = nil;

                -- If not neighbor tile
                elseif not (math.abs(self.highlighted_Tile.grid_X - self.highlighting_X) 
                        + math.abs(self.highlighted_Tile.grid_Y - self.highlighting_Y)  == 1) then 
                    game_Sounds['error']:play();
                    self.highlighted = false;
                    self.highlighted_Tile = nil;

                -- If satisfy all then swap them
                else
                    self:swapTile();
                end
            end
        end

        if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
            -- If no tile is highlighted
            if not self.highlighted then 
                self.highlighted = true;
                self.highlighted_Tile = self.board.tiles[self.highlighting_Y][self.highlighting_X]

            
            else
                -- If highlighting tile is already highlighted
                if self.highlighted_Tile.grid_X == self.highlighting_X and self.highlighted_Tile.grid_Y == self.highlighting_Y then
                    self.highlighted = false;
                    self.highlighted_Tile = nil;

                -- If not neighbor tile
                elseif not (math.abs(self.highlighted_Tile.grid_X - self.highlighting_X) 
                        + math.abs(self.highlighted_Tile.grid_Y - self.highlighting_Y)  == 1) then 
                    game_Sounds['error']:play();
                    self.highlighted = false;
                    self.highlighted_Tile = nil;

                -- If satisfy all then swap them
                else
                    self:swapTile();
                end
            end
        end

        if love.keyboard.wasPressed('escape') then
            love.event.quit();
        end
    end 

    Timer.update(dt);
end


-- SWAP 2 TILE FUNCTION
function PlayState:swapTile()
    self.user_Input = false;

    local tempX = self.highlighted_Tile.grid_X;
    local tempY = self.highlighted_Tile.grid_Y;

    local newTile = self.board.tiles[self.highlighting_Y][self.highlighting_X];

    self.highlighted_Tile.grid_X = newTile.grid_X;
    self.highlighted_Tile.grid_Y = newTile.grid_Y;
    newTile.grid_X = tempX;
    newTile.grid_Y = tempY;

    -- swap tiles in the tiles table
    self.board.tiles[self.highlighted_Tile.grid_Y][self.highlighted_Tile.grid_X] = self.highlighted_Tile;

    self.board.tiles[newTile.grid_Y][newTile.grid_X] = newTile;

    -- -- tween coordinates between the two so they swap
    Timer.tween(0.15, {
        [self.highlighted_Tile] = {x = newTile.x, y = newTile.y},
        [newTile] = {x = self.highlighted_Tile.x, y = self.highlighted_Tile.y}
    }):finish(function()
        self.highlighting_X = newTile.grid_X;
        self.highlighting_Y = newTile.grid_Y;
        self:checkReswap();
    end)
end


-- CHECK IF NEED TO SWAP AGAIN
function PlayState:checkReswap()
    local match = self.board:findMatch();
    if match then 
        self:updateBoard()
    else 
        local tempX = self.highlighted_Tile.grid_X;
        local tempY = self.highlighted_Tile.grid_Y;

        local newTile = self.board.tiles[self.highlighting_Y][self.highlighting_X];

        self.highlighted_Tile.grid_X = newTile.grid_X;
        self.highlighted_Tile.grid_Y = newTile.grid_Y;
        newTile.grid_X = tempX;
        newTile.grid_Y = tempY;

        -- swap tiles in the tiles table
        self.board.tiles[self.highlighted_Tile.grid_Y][self.highlighted_Tile.grid_X] = self.highlighted_Tile;

        self.board.tiles[newTile.grid_Y][newTile.grid_X] = newTile;

        -- -- tween coordinates between the two so they swap
        Timer.tween(0.15, {
            [self.highlighted_Tile] = {x = newTile.x, y = newTile.y},
            [newTile] = {x = self.highlighted_Tile.x, y = self.highlighted_Tile.y}
        })

        self.highlighted = false;
        self.highlighted_Tile = nil;
        self.user_Input = true;
    end
end

-- UPDATE BOARD FUNCTION AFTER MATCH
function PlayState:updateBoard()
    -- reset highlight
    self.highlighted = false;
    self.highlighted_Tile = nil;

    -- Check for matches
    local match = self.board:findMatch();
    if not (match == false)  then
        
        -- Loop through all match
        for k, matches in pairs(match) do 
            -- play match sound
            game_Sounds['match']:stop()
            game_Sounds['match']:play()
            -- Increase score
            self.score = self.score + #matches * 25;
            self.countdown = math.max(0, self.countdown - #matches);
        end
        
        -- Remove match tile
        self.board:removeMatch()

        local tile_Action = self.board:getFallingTiles()

        Timer.tween(0.5, tile_Action)
                                    :finish(function()
                                        self:updateBoard();    
                                    end)
    else
        self.user_Input = true;
    end
end


-- RENDER FUNCTION
function PlayState:render()
    self.board:render();

    -- DRAW HIGHLIGHTING TILE
    love.graphics.setLineWidth(4)
    love.graphics.setColor(1,0,0,1);
    love.graphics.rectangle('line', (self.highlighting_X - 1) * TILE_WIDTH + self.board.x, 
    (self.highlighting_Y - 1)* TILE_HEIGHT + self.board.y, TILE_WIDTH, TILE_HEIGHT, 4)

    -- DRAW HIGHLIGHED TILE
    if self.highlighted then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle('fill', (self.highlighted_Tile.grid_X - 1) * TILE_WIDTH + self.board.x, 
        (self.highlighted_Tile.grid_Y - 1)* TILE_HEIGHT + self.board.y, TILE_WIDTH, TILE_HEIGHT, 4)
    end

    -- DRAW MENU TABLE
    love.graphics.setColor(56/255, 56/255,56/255, 0.9)
    love.graphics.rectangle('fill', 10, 15, 200, 120);

    -- DRAW GUI TEXT
    love.graphics.setColor(56/255, 155/255, 1, 1);
    love.graphics.setFont(game_Fonts['mediumFont']);
    love.graphics.printf("Level: " .. tostring(self.level), 10, 23, 200, 'center');
    love.graphics.printf("Score: " .. tostring(self.score), 10, 53, 200, 'center');
    love.graphics.printf("Goal: " .. tostring(self.goal), 10, 83, 200, 'center');
    love.graphics.printf("Timer: " .. tostring(self.timer - self.countdown), 10, 113, 200, 'center');
end