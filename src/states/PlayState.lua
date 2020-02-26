PlayState = Class {__includes = BaseState}

function PlayState:init()
    -- Current highlighting tile
    self.highlighting_X = 1;
    self.highlighting_Y = 1;

    -- Higlighted tile
    self.highlighted = false;
    self.highlighted_Tile = nil;
end

-- ENTER FUNCTION
function PlayState:enter(params)
    self.level = params.level;
    self.board = params.board;
end

-- UPDATE FUNCTION
function PlayState:update(dt)
    Timer.update(dt);

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

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        if not self.highlighted then 
            self.highlighted = true;
            self.highlighted_Tile = self.board.tiles[self.highlighting_Y][self.highlighting_X]
        else
            self:swapTile();
            self.highlighted = false;
            self.highlighted_Tile = nil;
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit();
    end 
end


-- SWAP 2 TILE FUNCTION
function PlayState:swapTile()
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
    Timer.tween(0.1, {
        [self.highlighted_Tile] = {x = newTile.x, y = newTile.y},
        [newTile] = {x = self.highlighted_Tile.x, y = self.highlighted_Tile.y}
    })   
end

-- RENDER FUNCTION
function PlayState:render()
    self.board:render();

    -- DRAW HIGHLIGHTING TILE
    love.graphics.setColor(1,0,0,1);
    love.graphics.rectangle('line', (self.highlighting_X - 1) * TILE_WIDTH + self.board.x, 
    (self.highlighting_Y - 1)* TILE_HEIGHT + self.board.y, TILE_WIDTH, TILE_HEIGHT, 4)

    -- DRAW HIGHLIGHED TILE
    if self.highlighted then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle('fill', (self.highlighted_Tile.grid_X - 1) * TILE_WIDTH + self.board.x, 
        (self.highlighted_Tile.grid_Y - 1)* TILE_HEIGHT + self.board.y, TILE_WIDTH, TILE_HEIGHT, 4)
    end
end