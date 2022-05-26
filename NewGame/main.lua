require "collosion"

local STI = require("sti")
anim8 = require "libraries/anim8"

function love.load()
	love.window.setTitle( "Kicker" )

	Map = STI ("map/1.lua")
	-- Game Background --
	red = 30/255
    green = 170/255
    blue = 100/255
    color = { red, green, blue}

	-- Red cirlce --
	target = {}
	target.x = 300
	target.y = 300
	target.raduis = 25
	target.sprite = love.graphics.newImage("sprites/ball.png")

	-- Player Animation --
	player = {}
	player.x = 50
	player.y = 50
	player.w = 100
	player.h = 100

	player.spriteSheet = love.graphics.newImage("sprites/man.png")
	player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

	player.animations = {}
	player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2 )
	player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2 )
	player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2 )
	player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2 )

	player.anim = player.animations.left

	-- Game Score --
	score = 0
	timer = 0

	gameFont = love.graphics.newFont(40)

	-- Game Sounds --

	sounds = {}

	-- Musiek --
	sounds.music = love.audio.newSource("Sounds/music.mp3", "stream")
	sounds.music:setLooping(true)
	sounds.music:play()

	-- Sounds --
	sounds.crash = love.audio.newSource("Sounds/crash.mp3", "static")


	-- love.window.setFullscreen(true, "desktop")

end


function love.update(dt)

	local isMoving = false

	if ((love.keyboard.isDown('right')) and player.x < 750) then
		player.x = player.x + 4
		player.anim = player.animations.right
		isMoving = true
	end
	if ((love.keyboard.isDown('left')) and player.x > 0) then
		player.x = player.x - 4
		player.anim = player.animations.left
		isMoving = true
	end
	if ((love.keyboard.isDown('up') ) and player.y > 0) then
		player.y = player.y - 4
		player.anim = player.animations.up
		isMoving = true
	end
	if ((love.keyboard.isDown('down') ) and player.y < 425) then
		player.y = player.y + 4
		player.anim = player.animations.down
		isMoving = true
	end
	if isMoving == false then
		player.anim:gotoFrame(2)
	end

	player.anim:update(dt)

end


function love.draw()
	love.graphics.setColor(1, 1, 1)
	Map:draw(0, 0, 2, 2)

	-- Game Background --
	love.graphics.setBackgroundColor( color)

	-- Game Score --
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(gameFont)
	love.graphics.print(score, 0, 0)

	-- Red cirlce --
	love.graphics.setColor(1, 0.9, 2)
		love.graphics.draw(target.sprite, target.x, target.y, nil, 3)
	-- love.graphics.circle("fill", target.x, target.y, target.raduis)

	-- Blue rectangle --
	love.graphics.setColor(1, 1, 1)
	 player.anim:draw(player.spriteSheet,player.x, player.y, nil, 5)

	-- love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)


		if AABB(player.x, player.y, player.w, player.h, target.x, target.y, target.raduis) then
			sounds.crash:play()
			score = score + 1
			target.x = math.random(target.raduis, love.graphics.getWidth() - target.raduis)
			target.y = math.random(target.raduis, love.graphics.getHeight()- 100)
		end
end

love.keypressed = function(pressed_key, key)
	if pressed_key == 'escape' then
		love.event.quit()
	 end

	if key == "z" then
		sounds.music:stop()
	end

	if key == "x" then
		sounds.music:play()
	end
end

function distanceBetween(x1, y1, x2, y2)
	return math.sqrt ( (x2 - x1)^2 + (y2 - y1)^2 )

end