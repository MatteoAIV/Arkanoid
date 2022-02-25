Enemy = Object:extend()



function Enemy:new(spritesheet_path)
  self.anim = Animation(love.graphics.newImage(spritesheet_path), 48, 48, 2)
  self.anim.x = 100
  self.anim.y = 200
  self.spd = 100
  self.h_speed = love.math.random(-self.spd, self.spd)
  self.v_speed = love.math.random(-self.spd, self.spd)

  self.timer = Timer(2)
  self.timer:Start()

  self.stop_moving = false
end



function Enemy:Update(dt)
  self.anim.x = self.anim.x + self.h_speed * dt
  self.anim.y = self.anim.y + self.v_speed * dt
  self.anim:Update(dt)
  self:CheckBounds()

  if self.timer:Update(dt) then
    print("self timer update")
    if not self.stop_moving then
      self.stop_moving = true
      self.h_speed = 0
      self.v_speed = 0
    else
      self.stop_moving = false
      self.h_speed = love.math.random(-self.spd, self.spd)
      self.v_speed = love.math.random(-self.spd, self.spd)
    end

    self.timer:Start()
  end
end



function Enemy:CheckBounds()
  if self.anim.x <= LeftBorder or self.anim.x + 48 >= RightBorder then
    self.h_speed = 0
  end

  if self.anim.y <= TopBorder or self.anim.y + 48 >= ScreenHeight then
    self.h_speed = 0
  end

end



function Enemy:Draw()
  self.anim:Draw()
end
