Animation = Object:extend()



function Animation:new(image, width, height, duration)
  self.x = 0
  self.y = 0
  self.animation = {}
  self.animation.spritesheet = image
  self.animation.quads = {}

  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      table.insert(self.animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end

  self.animation.duration = duration or 1
  self.animation.current_time = 0
end



function Animation:Update(dt)
  self.animation.current_time = self.animation.current_time + dt

  if self.animation.current_time >= self.animation.duration then
    self.animation.current_time = self.animation.current_time - self.animation.duration
  end
end



function Animation:Draw()
  local sprite_index = math.floor(self.animation.current_time / self.animation.duration * #self.animation.quads) + 1
  love.graphics.draw(self.animation.spritesheet, self.animation.quads[sprite_index], self.x, self.y, 0, 1)
end
