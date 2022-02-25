require "player"
require "ball"
require "grid"
require "scene"

require "enemy"

Game = Scene:extend()

-- STATIC VARIABLES
Game.highscore, size = love.filesystem.read("HighScore.txt", all)
Game.highscore = tonumber(Game.highscore)

Game.backGround = love.graphics.newImage("Sprites/Background.png")
Game.foreGround = love.graphics.newImage("Sprites/Foreground.png")

Game.player = Player()
Game.ball = Ball()

Game.enemy_01 = Enemy("Sprites/Enemy_01.png")

Game.level_index = 1
Game.grid = Grid(all_levels[Game.level_index])

Game.life_lost = false
Game.game_over = false
Game.level_complete = false



function Game:new()
  Game.super.new(self)
end



function Game:Start()
  Game.super.Start(self)

  self.intro_timer = Timer(2.5)
  self.intro_timer:Start()
  self.start_game = false
  self.show_intro = true
  self.show_game_over = false

  self.life_lost_timer = Timer(2)
  self.level_complete_timer = Timer(1.5)
end



function Game:Input(key)
  Game.super.Input(self, key)

  -- SAVE PATH = C:\Users\matte\AppData\Roaming\LOVE\Lua - Lesson07

  if Game.game_over then
    local success, message  = love.filesystem.write("HighScore.txt", Game.highscore, all)

    if not success then
      print(message)
    else
      print("HighScore saved succesfully")
    end

    if key == "return" then
    self:Restart()
    end
  end
end



function Game:Update(dt)
  -- INTRO
  if self.intro_timer:Update(dt) then
    self.start_game = true
    self.intro_timer:Stop()
    self.show_intro = false
  end

  -- GAME LOOP
  if self.start_game and not Game.game_over then
    Game.super.Update(self, dt)

    Game.player:Update(dt)
    Game.ball:Update(dt)

    Game.enemy_01:Update(dt)
  end

  -- LIFE LOST
  if Game.life_lost then
    self.start_game = false
    self.life_lost_timer:Start()
    Game.life_lost = false
  end

  if self.life_lost_timer:Update(dt) then
    Game.player:LifeLost()
    if not Game.game_over then
      Game.player:Reset()
      Game.ball:Reset()
      self.life_lost_timer:Stop()
      self.intro_timer:Start()
      self.show_intro = true
    else
    -- GAME OVER
      self.life_lost_timer:Stop()
      self.show_game_over = true
    end
  end

  -- LEVEL COMPLETE
  if #Game.grid.bricks == 0 and not Game.level_complete then
    print("level complete")
    Game.level_complete = true
    self.start_game = false
    self.level_complete_timer:Start()
  end

  if self.level_complete_timer:Update(dt) then
    print("restart")
    Game.level_complete = false
    self.level_complete_timer:Stop()
    self:NextLevel()
  end
end



function Game:Restart()
  Game.player:Reset()
  Game.ball:Reset()
  Game.player.tokens = Game.player.max_tokens
  Game.player.score = 0

  self.intro_timer:Stop()
  self.intro_timer:Start()
  self.start_game = false
  self.show_intro = true
  self.show_game_over = false
  Game.game_over = false

  Game.level_index = 1
  Game.grid = Grid(all_levels[Game.level_index])

  self.next_scene = title
  self:OnExit()
end



function Game:NextLevel()
  Game.player:Reset()
  Game.ball:Reset()
  Game.player.tokens = Game.player.max_tokens
  Game.player.score = 0

  self.intro_timer:Stop()
  self.intro_timer:Start()
  self.start_game = false
  self.show_intro = true
  self.show_game_over = false
  Game.game_over = false

  Game.level_index = Game.level_index + 1
  Game.grid = Grid(all_levels[Game.level_index])
end



function Game:OnExit()
  Game.super.OnExit(self)
end



function Game:Draw()
  Game.super.Draw(self)

  love.graphics.draw(Game.backGround, 0, 0)
  love.graphics.draw(Game.foreGround, 0, 0)

  Game.player:Draw()
  Game.ball:Draw()
  Game.grid:Draw()

  Game.enemy_01:Draw()

  love.graphics.print(Game.player.score, 100, 30)

  if Game.player.score > Game.highscore then
      Game.highscore = Game.player.score
  end

  love.graphics.print(Game.highscore, 300, 30)

  if not self.start_game and self.show_intro then
    love.graphics.print("GET READY TO PLAY", 200, 600)
  end

  if self.show_game_over then
    love.graphics.print("GAME OVER", 260, 500)
    love.graphics.print("PRESS START TO PLAY AGAIN", 130, 550)
    love.graphics.print("PRESS ESC TO QUIT", 190, 600)
  end
end
