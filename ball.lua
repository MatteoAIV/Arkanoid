require "AABB"



Ball = Object:extend()



function Ball:new()
  self.width = 15
  self.height = 12
  self.shadow_offset = 12

  self.x = ScreenCenterX - self.width * .5
  self.y = 500

  self.spd = 250
  self.hSpd = love.math.random(-self.spd, self.spd)
  self.vSpd = -self.spd

  self.sprite = love.graphics.newImage("Sprites/Ball.png")
  self.shadow = love.graphics.newImage("Sprites/Ball_Shadow.png")
  
  self.number = 0
end



function Ball:Update(dt)
  self:Move(dt)
  self:CheckBounds()
  self:CheckPlayerCollision()
  self:CheckBrickCollision()
end



function Ball:Move(dt)
  self.x = self.x + self.hSpd * dt
  self.y = self.y + self.vSpd * dt
end



function Ball:CheckBounds()
  if self.x <= LeftBorder then
    self.x = LeftBorder
    self.hSpd = -self.hSpd
  end

  if self.x + self.width >= RightBorder then
    self.x = RightBorder - self.width
    self.hSpd = -self.hSpd
  end

  if self.y <= TopBorder then
    self.y = TopBorder
    self.vSpd = -self.vSpd
  end

  if self.y + self.height >= ScreenHeight then
    --self.y = ScreenHeight - self.height
    --self.vSpd = -self.vSpd

    Game.life_lost = true
  end
end


-- To check Ball-Player's collision we need to use a well known formula (AABB), used in 2D geometry
-- to check if two boxes are overlapping.

-- Two boxes are overlapping if one of the vertices of one of the 2 boxes are "inside" the other box
-- This can be checked dividing the problem into 2 sub-problems and resolving them individually
-- So we check Horizontal and Vertical Collision separately, but we know that a true collision happens
-- only when both are true, then we use both the functions's results to determine if a collision happened

-- Now we know a collision occurred. Now we have to reset the boxes into their correct position
-- (no solid object can be compenetrated), so we have to know which side the collision happened first
-- and reset the positions accordingly
-- We use shiftX and shiftY to record the amount of compenetration occurred both horizontally and vertically
-- We assume that the minimal amount of compenetration is the side we collided from
-- Based on those informations we are able to calculate the correct collision and reset everything correctly
function Ball:CheckPlayerCollision()
  local overlap, shiftX, shiftY
  overlap, shiftX, shiftY = AABB(Game.player.x, Game.player.y, Game.player.width, Game.player.height, self.x, self.y, self.width, self.height)

  if overlap then
    self:Rebound(shiftX, shiftY)
  end
end



function Ball:CheckBrickCollision()
  local overlap, shiftX, shiftY

  for i = 1,#Game.grid.bricks, 1 do
    overlap, shiftX, shiftY = AABB(Game.grid.bricks[i].x, Game.grid.bricks[i].y, Game.grid.bricks[i].width, Game.grid.bricks[i].height, self.x, self.y, self.width, self.height)

    if overlap then
      self:Rebound(shiftX, shiftY)

      Game.grid.bricks[i].hits = Game.grid.bricks[i].hits - 1

      if Game.grid.bricks[i].hits <= 0 then
        Game.player.score = Game.player.score + Game.grid.bricks[i].points
        table.remove(Game.grid.bricks, i)
      end
      return
    end
  end
end



function Ball:Rebound(shiftX, shiftY)
  local minShift = math.min(math.abs(shiftX), math.abs(shiftY))

  if(math.abs(shiftX) == minShift) then
    shiftY = 0
    self.hSpd = -self.hSpd
  else
    shiftX = 0
    self.vSpd = -self.vSpd
    self.hSpd = love.math.random(-self.spd, self.spd)
  end

  self.x = self.x + shiftX
  self.y = self.y + shiftY
end



function Ball:Reset()
  self.x = ScreenCenterX - self.width * .5
  self.y = 500
  self.spd = 250
  self.hSpd = love.math.random(-self.spd, self.spd)
  self.vSpd = -self.spd
end



function Ball:Draw()
  love.graphics.draw(self.shadow, self.x + self.shadow_offset, self.y + self.shadow_offset)
  love.graphics.draw(self.sprite, self.x, self.y)
end
