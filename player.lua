Player = Object:extend()



function Player:new()
  self.width = 96
  self.height = 24

  self.x = ScreenWidth * .5 - self.width * .5
  self.y = ScreenHeight - 72

  self.spd = 0
  self.maxSpd = 500

  --self.sprite = love.graphics.newImage("Sprites/Player.png")
  self.sprite_shadow = love.graphics.newImage("Sprites/Player_Shadow.png")

  self.token = love.graphics.newImage("Sprites/Player_Token.png")
  self.token_shadow = love.graphics.newImage("Sprites/Player_Token_Shadow.png")

  self.shadow_offset = 8
  self.token_width = 36

  self.max_tokens = 1
  self.tokens = self.max_tokens

  self.score = 0

  self.anim = Animation(love.graphics.newImage("Sprites/Player_SpriteSheet.png"), 96, 24, 2)
  self.anim.x = self.x
  self.anim.y = self.y
end



function Player:Update(dt)
  self:Input()
  self:Move(dt)
  self:CheckBounds()

  self.anim.x = self.x
  self.anim.y = self.y
  self.anim:Update(dt)
end



function Player:Move(dt)
  self.x = self.x + self.spd * dt
end



function Player:CheckBounds()
  if self.x <= LeftBorder then
    self.x = LeftBorder
    self.spd = 0
  end

  if self.x + self.width >= RightBorder then
    self.x = RightBorder - self.width
  end
end



function Player:Input()
  if love.keyboard.isDown("d") then
    self.spd = self.maxSpd
  elseif love.keyboard.isDown("a") then
    self.spd = -self.maxSpd
  else
    self.spd = 0
  end
end



function Player:LifeLost()
  self.tokens = self.tokens - 1

  if self.tokens < 0 then
    Game.game_over = true
  end
end



function Player:Reset()
  self.x = ScreenWidth * .5 - self.width * .5
  self.y = ScreenHeight - 72
  self.spd = 0

  self.anim.x = self.x
  self.anim.y = self.y
end



function Player:Draw()
  love.graphics.draw(self.sprite_shadow, self.x + self.shadow_offset, self.y + self.shadow_offset)
  --love.graphics.draw(self.sprite, self.x, self.y)

  for i = 1, self.tokens, 1 do
    local x = LeftBorder + (i - 1) * self.token_width
    local y = ScreenHeight - self.token_width * 0.5
    love.graphics.draw(self.token_shadow, x + self.shadow_offset * 0.5, y + self.shadow_offset * 0.5)
    love.graphics.draw(self.token, x, y)
  end

  self.anim:Draw()
end
