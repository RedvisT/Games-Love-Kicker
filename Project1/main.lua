remove("menu")
require("player")
require("ball")

local STI = require("sti")

function love.load()
    Map = STI ("map/1.lua")
    red = 1
    green = 1
    blue = 1
    color = { red, green, blue}

    Player1:load()
    Player2:load()
    Ball:load()

    sounds = {}
    sounds.music = love.audio.newSource("Sounds/computerWorld.mp3", "stream")
	sounds.music:setLooping(true)
	sounds.music:play()

end

function love.update(dt)
    Player1:update(dt)
    Player2:update(dt)
    Ball:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor( color)
    Map:draw(0, 0, 2, 2)

    Player1:draw()
    Player2:draw()
    Ball:draw()
end

function checkCollision(a, b)
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
