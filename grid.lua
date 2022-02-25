require "brick"

Grid = Object:extend()

local max_bricks_per_row = 13
local max_bricks_per_col = 20
local cell_width = 48
local cell_height = 24



function Grid:new(level)
  self.bricks = {}

  local color
  local hits
  local brick

  for i = 1, #level, 1 do
    if level[i] == "C" then
      color = "Cyan"
      hits = 1
    elseif level[i] == "R" then
      color = "Red"
      hits = 1
    elseif level[i] == "G" then
      color = "Gray"
      hits = 1
    elseif level[i] == "Y" then
      color = "Yellow"
      hits = 1
    elseif level[i] == "P" then
      color = "Purple"
      hits = 1
    elseif level[i] == "N" then
      color = "Green"
      hits = 1
    elseif level[i] == "W" then
      color = "White"
      hits = 1
    elseif level[i] == "B" then
      color = "Blue"
      hits = 1
    elseif level[i] == "O" then
      color = "Orange"
      hits = 1
    elseif level[i] == "GD" then
      color = "Gray_Double"
      hits = 2
    else
      color = " "
    end

    if color ~= " " then
      local brick = Brick(color,
                      LeftBorder + (i - 1) % max_bricks_per_row * cell_width,
                      TopBorder + math.floor((i - 1) / max_bricks_per_row) * cell_height,
                      hits)
      table.insert(self.bricks, brick)
    end
  end
end



function Grid:Draw()
  for i = 1, #self.bricks, 1 do
    self.bricks[i]:Draw()
  end
end
