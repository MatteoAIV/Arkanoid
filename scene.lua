Scene = Object:extend()



function Scene:new()

end



function Scene:Start(next_scene)
  if next_scene ~= nil then
    self.next_scene = next_scene
  end
end



function Scene:Input(key)
  if key == "escape" then
    love.event.quit()
  end
end



function Scene:Update(dt)

end



function Scene:OnExit()
  current_scene = self.next_scene
  current_scene:Start()
end



function Scene:Draw()

end
