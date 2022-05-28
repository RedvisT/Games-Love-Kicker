
require("player")
require("ball")

local STI = require("sti")
local gameState = ""


function love.load()
    GamePause = true
    Map = STI ("map/1.lua")
    MapMenu = STI ("map/2.lua")

    Player1:load()
    Player2:load()
    Ball:load()

    Sounds = {}
        Sounds.music = love.audio.newSource("Sounds/computerWorld.mp3", "stream")
        Sounds.music:setLooping(true)
        Sounds.music:play()

    Sounds.crash = love.audio.newSource("Sounds/crash.mp3", "static")

    Score = {}
        ScoreA = 0
        ScoreB = 0

    gameState = "MainMenu"

end

function love.update(dt)
    if GamePause == false then
        if  gameState == "Play" then
                Player1:update(dt)
                Player2:update(dt)
                Ball:update(dt)
        end
    end

end

function love.draw()
    if gameState == "MainMenu" then
        MapMenu:draw(0, 0, 1.35, 1.6)
        love.graphics.print( "Game Menu", love.graphics.getWidth() / 2.4 , 25, 0, 2.5)
        love.graphics.print( "Press Enter to Start", love.graphics.getWidth() / 2.5 , 100, 0, 2)
        love.graphics.print( "Press z to Stop Music", love.graphics.getWidth() / 2.55 , 125, 0, 2)
        love.graphics.print( "Press x to Start Music", love.graphics.getWidth() / 2.58 , 150, 0, 2)
        love.graphics.print( "Press Esc to Exit", love.graphics.getWidth() / 2.39 , 175, 0, 2)

        love.graphics.print( "Controls", love.graphics.getWidth() / 2.25 , 225, 0, 2.5)
        love.graphics.print( "Player 1 Press w to go up", love.graphics.getWidth() / 2.7 , 275, 0, 2)
        love.graphics.print( "Player 1 Press s to go down", love.graphics.getWidth() / 2.8 , 300, 0, 2)
        love.graphics.print( "Player 2 Press up to go up", love.graphics.getWidth() / 2.75 , 325, 0, 2)
        love.graphics.print( "Player 2 Press down to go down", love.graphics.getWidth() / 3 , 350, 0, 2)
        love.graphics.print( "Press Spacebar to Start", love.graphics.getWidth() / 2.65 , 400, 0, 2)
        love.graphics.print( "Press p to Pause Game", love.graphics.getWidth() / 2.6 , 425, 0, 2)

    end
    if gameState == "Play" then
        Map:draw(0, 0, 2, 2)

        love.graphics.print( "Space Ball", love.graphics.getWidth() / 2.6 , 0, 0, 4)

        love.graphics.print( "Player 1", 0, 0, 0, 2)
        love.graphics.print( "Score", 0, 50, 0, 2)
        love.graphics.print(ScoreA, 100, 50, 0, 2)

        love.graphics.print( "Player 2", love.graphics.getWidth() -160, 0, 0, 2)
        love.graphics.print( "Score", love.graphics.getWidth() -160, 50, 0, 2)
        love.graphics.print(ScoreB, love.graphics.getWidth() -50,  50, 0, 2)

        -- love.graphics.print( "Player 1 Win !!!!", love.graphics.getWidth() / 3.1 , 300, 0, 4)
        -- love.graphics.print( "Player 2 Win !!!!", love.graphics.getWidth() / 3.1 , 300, 0, 4)

        Player1:draw()
        Player2:draw()
        Ball:draw()
    end
end


function CheckCollision(a, b)
    if  a.x + a.width > b.x and
        a.x < b.x + b.width and
        a.y + a.height > b.y and
        a.y < b.y + b.height then
        return true

    elseif  a.x - a.width < b.x and
    a.x > b.x - b.width and
    a.y - a.height < b.y and
    a.y > b.y - b.height then
        return true

    else
        return false
    end
end


love.keypressed = function(pressed_key, key)
	if pressed_key == 'escape' then
		love.event.quit()
	 end

	if key == "z" then
		Sounds.music:stop()
	end

	if key == "x" then
		Sounds.music:play()
	end

    if key == "return" then
        if gameState == "MainMenu" then
            gameState = "Play"
        end
    end

    if key == "space" then
        GamePause = false
    end

    if key == "p" then
        GamePause = true
    end
end


