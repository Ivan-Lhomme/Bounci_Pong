Ball = {}
Ball.__index = Ball

function Ball:new(world)
    local ball = {}
    setmetatable(ball, self)

    ball.startX = 395
    ball.startY = 295
    ball.velocity = {-200, 200}

    ball.collider = world:newRectangleCollider(ball.startX, ball.startY, 10, 10)
    ball.collider:setType('kinematic')
    ball.collider:setCollisionClass('Ball')
    
    ball.collider:setLinearVelocity(ball.velocity[love.math.random(1, 2)], 0)

    return ball
end

function Ball:reset()
    self.velocity = {-200, 200}
    self.collider:setPosition(self.startX, self.startY)
    self.collider:setLinearVelocity(self.velocity[love.math.random(1, 2)], 0)
end

function Ball:draw()
    colliderDraw(self.collider)
end

function Ball:touch()
    if self.collider:enter('Entity') then
        self.velocity[1] = self.velocity[1] + 10
        self.velocity[2] = self.velocity[2] + 10

        if self.collider:getLinearVelocity() == self.velocity[1] then
            self.collider:setLinearVelocity(self.velocity[1], 0)
        else
            self.collider:setLinearVelocity(self.velocity[2], 0)
        end

        --gameStop = true
    end
end

return Ball