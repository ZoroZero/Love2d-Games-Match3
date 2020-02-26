Board = Class{}

-- INIT FUNCTION
function Board:init( x, y )
    self.x = x;
    self.y = y;

    self.match = {};
    self:initialized_Tiles();
end

-- INITIALIZED TILES
function Board:initialized_Tiles()
    self.tiles = {}
    for y = 1, 8 do 
        table.insert(self.tiles, {})
        for x = 1, 8 do 
            table.insert(self.tiles[y], Tile(x, y, math.random(1,18), math.random(1, 6)));
        end
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