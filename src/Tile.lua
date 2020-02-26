
Tile = Class{}

-- INIT FUNCTION
function Tile:init(grid_X, grid_Y, color, variety)
    -- Grid positions
    self.grid_X = grid_X;
    self.grid_Y = grid_Y;

    -- POSITION ON SCREEN
    self.x = (self.grid_X - 1) * TILE_WIDTH;
    self.y = (self.grid_Y - 1) * TILE_HEIGHT;

    -- COLOR AND VARIETY
    self.color = color;
    self.variety = variety;
end


-- RENDER FUNCTION
function Tile:render( x, y )
    -- Draw shadow
    love.graphics.setColor(0,0,0,255);
    love.graphics.draw(game_Textures['main'], game_Frames['tiles'][self.color][self.variety], 
     x + self.x + 3, self.y + y + 3);

    -- Draw tiles
    love.graphics.setColor(255,255,255,255);
    love.graphics.draw(game_Textures['main'], game_Frames['tiles'][self.color][self.variety], 
    self.x + x,self.y + y);
end