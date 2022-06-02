-- The Ball --

Ball = {}


function Ball:load()
    -- Ball Location --
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    -- Ball Image and Size --
    self.img = love.graphics.newImage("assets/peg.png")
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    -- Ball Speed --
    self.speed = 800
    self.xVel = -self.speed
    self.yVel = 0
end

-- Update Function --
function Ball:update(dt)
    self:move(dt)
    self:collide()
end

-- Collide Parameters --
function Ball:collide()
    Ball:collideWall()
    Ball:collidePlayer1 ()
    Ball:collidePlayer2 ()
    Ball:collideAI()
    Ball:score()
end


-- Collide Parameters --
function Ball:collideWall()
    if  self.y < 0 then
        self.y = 0
        self.yVel = -self.yVel
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVel = -self.yVel
    end
end

-- Player 1  Parameters --
function Ball:collidePlayer1 ()
    if CheckCollision(self, Player1) then
        self.xVel = self.speed
        local middleBall = self.y + self.height / 2
        local middlePayer1 = Player1.y + Player1.height / 2
        local collisionPosition = middleBall - middlePayer1
        self.yVel = collisionPosition * 5
    end
end

-- Player 2 Parameters --
function Ball:collidePlayer2 ()
    if CheckCollision(self, Player2) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middlePayer2 = Player2.y + Player2.height / 2
        local collisionPosition = middleBall + middlePayer2
        self.yVel = collisionPosition / 5
    end
end

-- AI Parameters --
function Ball:collideAI()
    -- AI Parameters --
    if CheckCollision(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middleAI = AI.y + AI.height / 2
        local collisionPosition = middleBall + middleAI
        self.yVel = collisionPosition / 5
    end
end


-- Player Score Parameters --
function Ball:score()
    if self.x < 0 then
        self:resetPosition(1)
        ScoreB = ScoreB + 1
        Sounds.crash:play()
    end

    -- AI Parameters --
    if self.x + self.width > love.graphics.getWidth() then
        self:resetPosition(-1)
        ScoreA = ScoreA + 1
        Sounds.crash:play()
    end
end


function Ball:resetPosition(modifier)
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVel = 0
    self.xVel = self.speed * modifier
end

-- Ball Movement --
function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end


-- Ball View Create --
function Ball:draw()
    love.graphics.draw(self.img, self.x, self.y)
end



