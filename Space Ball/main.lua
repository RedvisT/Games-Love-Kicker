
require("playerone")
require("playertwo")
require("playerai")
require("ball")
require("states/game")

local STI = require("sti")
local gameState = ""

BUTTON_HEIGHT = 64

local
function newButton(text, fn)
    return {
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

local buttons = {}
local font = nil


function love.load()
    font = love.graphics.newFont(32)
    table.insert(buttons, newButton(
        "OnePlayer",
        function ()
            if gameState == "MainMenu" then
                gameState = "OnePlayer"
            end
        end))

        table.insert(buttons, newButton(
        "TwoPlayer",
        function ()
            if gameState == "MainMenu" then
                gameState = "TwoPlayer"
            end
        end))

        table.insert(buttons, newButton(
            "Controls",
            function ()
                if gameState == "MainMenu" then
                    gameState = "Controls"
                end
            end))

        table.insert(buttons, newButton(
        "Exit",
        function ()
            love.event.quit(0)
        end))

    GamePause = true
    Map = STI ("map/1.lua")
    MapMenu = STI ("map/2.lua")

    Game = Game()

    Player1:load()
    Player2:load()
    AI:load()
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

love.keypressed = function(key)
    if Game.state.OnePlayer then
        -- Sound Off --
        if key == "z" then
            Sounds.music:stop()
        end
        -- Sound On --
        if key == "x" then
            Sounds.music:play()
        end
        -- Play --
        if key == "space" then
            GamePause = false
        end
        -- Pause --
        if key == "p" then
            GamePause = true
        end
        -- Escape to MainMenu --
        if key == "escape" then
            if gameState == "OnePlayer" then
            gameState = "MainMenu"
            end
        end
    end

    if Game.state.TwoPlayer then
        -- Sound Off --
        if key == "z" then
            Sounds.music:stop()
        end
        -- Sound On --
        if key == "x" then
            Sounds.music:play()
        end
        -- Play --
        if key == "space" then
            GamePause = false
        end
        -- Pause --
        if key == "p" then
            GamePause = true
        end
        -- Escape to MainMenu --
        if key == "escape" then
            if gameState == "TwoPlayer" then
            gameState = "MainMenu"
            end
        end
    end

    if Game.state.Controls then
        -- Sound Off --
        if key == "z" then
            Sounds.music:stop()
        end
        -- Sound On --
        if key == "x" then
            Sounds.music:play()
        end
        -- Play --
        if key == "space" then
            GamePause = false
        end
        -- Pause --
        if key == "p" then
            GamePause = true
        end
        -- Escape to MainMenu --
        if key == "escape" then
            if gameState == "Controls" then
            gameState = "MainMenu"
            end
        end
    end
end

-- Game Update --
function love.update(dt)
    if Game.state.OnePlayer then
        if GamePause == false then
            if  gameState == "OnePlayer" then
                Player1:update(dt)
                -- AI:update(dt)
                Ball:update(dt)
            end
        end
    end

    if Game.state.TwoPlayer then
        if GamePause == false then
            if  gameState == "TwoPlayer" then
                Player1:update(dt)
                Player2:update(dt)
                Ball:update(dt)
            end
        end
    end
end



-- Check Collision Parameters --
function CheckCollision(ball, player)
    if  ball.x + ball.width > player.x and
        ball.x < player.x + player.width and
        ball.y + ball.height > player.y and
        ball.y < player.y + player.height then
        return true

    elseif  ball.x - ball.width < player.x and
    ball.x > player.x - player.width and
    ball.y - ball.height < player.y and
    ball.y > player.y - player.height then
        return true

    else
        return false
    end
end

function love.draw()
    if gameState == "MainMenu" then
            love.graphics.setColor(1, 1, 1, 1)
            MapMenu:draw(0, 0, 1.35, 1.6)
            love.graphics.print( "Game Menu",475 , 25, 0, 2)
            local ww = love.graphics.getWidth()
            local wh = love.graphics.getHeight()
            local button_width = ww * (1/3)
            local margin = 16
            local total_height = (BUTTON_HEIGHT - margin) * #buttons
            local cursor_y = 0

        for i, button in ipairs(buttons) do
            button.last = button.now

            local bx = (ww / 2) - (button_width / 2)
            local by = (wh / 2) - (total_height / 2) + cursor_y
            local color = {0.4, 0.4, 0.5, 1.0}
            local mx, my = love.mouse.getPosition()
            local hot = mx > bx and mx < bx + button_width and
                        my > by and my < by + BUTTON_HEIGHT

            if hot then
                color = {0.8, 0.8, 0.9, 1.0}
            end

            button.now = love.mouse.isDown(1)
            if button.now and not button.last and hot then
                button.fn()
            end

            love.graphics.setColor(unpack(color))
            love.graphics.rectangle("fill",bx , by, button_width, BUTTON_HEIGHT)

                love.graphics.setColor(0, 0, 0, 1)

                local textW = font:getWidth(button.text)
                local textH = font:getHeight(button.text)

                love.graphics.print(
                    button.text,
                    font,
                    (ww / 2) - textW / 2,
                    by + textH / 2

                )
                cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
        end

    end


    if gameState == "OnePlayer" then
        Map:draw(0, 0, 1.5, 1.2)

        love.graphics.print( "Space Ball", love.graphics.getWidth() / 2.6 , 0, 0, 4)

        love.graphics.print( "Player 1", 0, 0, 0, 2)
        love.graphics.print( "Score", 0, 50, 0, 2)
        love.graphics.print(ScoreA, 100, 50, 0, 2)

        love.graphics.print( "Computer", love.graphics.getWidth() -160, 0, 0, 2)
        love.graphics.print( "Score", love.graphics.getWidth() -160, 50, 0, 2)
        love.graphics.print(ScoreB, love.graphics.getWidth() -50,  50, 0, 2)

        -- love.graphics.print( "Player 1 Win !!!!", love.graphics.getWidth() / 3.1 , 300, 0, 4)
        -- love.graphics.print( "Player 2 Win !!!!", love.graphics.getWidth() / 3.1 , 300, 0, 4)

        Player1:draw()
        AI:draw()
        Ball:draw()
    end

    if gameState == "TwoPlayer" then
        Map:draw(0, 0, 1.5, 1.2)

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

    if gameState == "Controls" then
        love.graphics.setColor(1, 1, 1, 1)
        MapMenu:draw(0, 0, 1.35, 1.6)
        love.graphics.print( "Buttons",0 , 25, 0, 2)
        love.graphics.print( "Press Enter to Start", 0, 60, 0, 1)
        love.graphics.print( "Press z to Stop Music", 0, 80, 0, 1)
        love.graphics.print( "Press x to Start Music", 0, 100, 0, 1)
        love.graphics.print( "Press Esc to Exit", 0, 120, 0, 1)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print( "Controls", love.graphics.getWidth() - 250, 25, 0, 2)
        love.graphics.print( "Player 1 Press w to go up", love.graphics.getWidth() - 250 , 60, 0, 1)
        love.graphics.print( "Player 1 Press s to go down", love.graphics.getWidth() - 250 , 80, 0, 1)
        love.graphics.print( "Player 2 Press up to go up", love.graphics.getWidth() - 250 , 100, 0, 1)
        love.graphics.print( "Player 2 Press down to go down", love.graphics.getWidth() - 250 , 120, 0, 1)
        love.graphics.print( "Press Spacebar to Start", love.graphics.getWidth() - 250, 140, 0, 1)
        love.graphics.print( "Press p to Pause Game", love.graphics.getWidth() - 250 , 160, 0, 1)
    end
end