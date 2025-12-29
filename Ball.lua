Ball = {}
Ball.__index = Ball

function Ball:new(world)
    local ball = {}
    setmetatable(ball, self)

    ball.startX = 395
    ball.startY = 295

    ball.vx = {-200, 200}
    ball.vy = {0, 0}

    ball.collider = world:newRectangleCollider(ball.startX, ball.startY, 10, 10)
    ball.collider:setType('kinematic')
    ball.collider:setCollisionClass('Ball')
    
    ball.collider:setLinearVelocity(ball.vx[love.math.random(1, 2)], 0)

    return ball
end

function Ball:reset()
    self.vx = {-200, 200}
    self.vy = {0, 0}

    self.collider:setPosition(self.startX, self.startY)
    self.collider:setLinearVelocity(self.vx[love.math.random(1, 2)], 0)
end

function Ball:draw()
    colliderDraw(self.collider)
end

function Ball:touch()
    if self.collider:enter('Entity') then
        local vx, vy = self.collider:getLinearVelocity()
        
        self.vx[1] = self.vx[1] - 40
        self.vx[2] = self.vx[2] + 40

        if vx < 0 then
            self.collider:setLinearVelocity(self.vx[2], 0)
        else
            self.collider:setLinearVelocity(self.vx[1], 0)
        end
    end
end

return Ball