require "scene"
require "timer"



Title = Scene:extend()



function Title:new()
  Title.super.new(self)
end



function Title:Start(next_scene)
  Title.super.Start(self, next_scene)
  self.title_screen = love.graphics.newImage("Sprites/Arkanoid_Title.png")

  self.show_start_btn = false

  self.start_timer = Timer(1)
  self.start_timer:Start()
end



function Title:Input(key)
  Title.super.Input(self, key)

  if key == "return" then
    self:OnExit()
  end
end



function Title:Update(dt)
  if self.start_timer:Update(dt) then
    self.show_start_btn = not self.show_start_btn
    self.start_timer:Start()
  end
end



function Title:OnExit()
  Title.super.OnExit(self)
end



function Title:Draw()
  love.graphics.draw(self.title_screen, 146, 123)

  if self.show_start_btn then
    love.graphics.print("PRESS START TO PLAY", 180, 600)
  end
end
