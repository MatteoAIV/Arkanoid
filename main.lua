require "levels"



-- GLOBAL VARIABLES
ScreenWidth = 672
ScreenHeight = 768
ScreenCenterX = ScreenWidth * .5
ScreenCenterY = ScreenHeight * .5
LeftBorder = 24
RightBorder = 648
TopBorder = 72



function love.load()
  -- REQUIREMENTS
  Object = require("classic")
  require "scene_title"
  require "animation"
  require "scene_game"

  -- GENERAL SETUP
  love.window.setMode(ScreenWidth, ScreenHeight)

  -- Create and Set a new Font
  font = love.graphics.newImageFont( 'sprites/Font_Complete.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' )
  love.graphics.setFont(font)

  -- SCENES SETUP
  title = Title()
  game = Game()

  current_scene = title
  current_scene:Start(game)
end



function love.keypressed(key, scancode, isrepeat)
    current_scene:Input(key)
end



function love.update(dt)
  current_scene:Update(dt)
end



function love.draw()
  current_scene:Draw()
end
