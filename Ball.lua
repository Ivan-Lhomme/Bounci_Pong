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
        local collisionData = self.collider:getEnterCollisionData('Entity')
        local collisionCollider = collisionData.collider:getObject()

        local x1, y1 = collisionCollider.collider:getPosition()
        local x2, y2 = self.collider:getPosition()

        local vx, vy = self.collider:getLinearVelocity()

        local distance = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)*2
        self.vy[1] = -distance
        self.vy[2] = distance
        
        if (self.vx[2] + 40) <= 640 then
            self.vx[1] = self.vx[1] - 40
            self.vx[2] = self.vx[2] + 40
        elseif not (self.vx[2] == 640) then
            self.vx[2] = 640
        end

        local vChoose = {1, 1}
        if vx < 0 then
            vChoose[1] = 2
        end

        if y2 > y1 then
            vChoose[2] = 2
        end

        self.collider:setLinearVelocity(self.vx[vChoose[1]], self.vy[vChoose[2]])
    end

    local x = self.collider:getX()
    if x < -2 or x > 802 then
        restartGame()
    end
end

return Ball