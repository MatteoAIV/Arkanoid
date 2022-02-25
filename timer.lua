Timer = Object:extend()



function Timer:new(max)
  self.max_time = max
  self.run = false
end



function Timer:Start()
  self.timer = 0
  self.run = true
end



function Timer:Pause()
  self.run = false
end



function Timer:Stop()
  self.timer = 0
  self.run = false
end



function Timer:Update(dt)
  if self.run then
    self.timer = self.timer + dt

    if self.timer >= self.max_time then
      return true
    else
      return false
    end
  end
end
