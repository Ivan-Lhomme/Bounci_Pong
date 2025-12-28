Ball = {}
Ball.__index = Ball

ball.velocity = {-200, 200}

function Ball:new(world)
    local ball = {}
    setmetatable(ball, self)

    ball.startX = 395
    ball.startY = 295

    ball.collider = world:newRectangleCollider(ball.startX, ball.startY, 10, 10)
    ball.collider:setType('kinematic')
    ball.collider:setCollisionClass('Ball')

    return ball
end

function Ball:reset()
    self.velocity = {-200, 200}
    self.collider:setPosition(self.startX, self.startY)
    self.collider:setLinearVelocity(self.startVelocity[love.math.random(1, 2)], 0)
end

function Ball:draw()
    colliderDraw(self.collider)
end

return Ball