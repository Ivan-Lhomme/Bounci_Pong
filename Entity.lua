Entity = {}
Entity.__index = Entity

function Entity:new(x, y, height, world)
    local entity = {}
    setmetatable(entity, self)

    entity.x = x
    entity.startY = y

    entity.jumpCooldown = 0

    entity.collider = world:newRectangleCollider(entity.x, entity.startY, 10, height)
    entity.collider:setRestitution(0.5)
    entity.collider:setCollisionClass('Entity')
    entity.collider:setObject(entity)

    return entity
end

function Entity:reset()
    self.collider:setPosition(self.x + 5, self.startY + 100)
    self.collider:setLinearVelocity(0, 0)
    self.collider:setAngle(0)
end

function Entity:draw()
    colliderDraw(self.collider)
end

function Entity:jump()
    if self.jumpCooldown <= 0 then
        self.collider:applyLinearImpulse(0, -2500)
        self.jumpCooldown = 0.5
    end
end

function Entity:fJumpCooldown(dt)
    if self.jumpCooldown > 0 then
        self.jumpCooldown = self.jumpCooldown - dt
    end
end

return Entity