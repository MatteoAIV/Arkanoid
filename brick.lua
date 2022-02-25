Brick = Object:extend()



function Brick:new(color, x, y, hits)
  self.width = 48
  self.height = 24
  self.shadow_offset = 8

  self.x = x
  self.y = y
  self.hits = hits
  self.points = 10 * hits

  self.sprite = love.graphics.newImage("Sprites/Brick_" .. color .. ".png")
  self.shadow = love.graphics.newImage("Sprites/Brick_Shadow.png")
end



function Brick:Draw()
  love.graphics.draw(self.shadow, self.x + self.shadow_offset, self.y + self.shadow_offset)
  love.graphics.draw(self.sprite, self.x, self.y)
end
