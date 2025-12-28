Entity = {}
Entity.__index = Entity

function Entity:new(x, y, height, world)
    local entity = {}
    setmetatable(entity, self)

    entity.startX = x
    entity.startY = y

    entity.collider = world:newRectangleCollider(entity.startX, entity.startY, 10, height)
    entity.collider:setRestitution(0.5)
    entity.collider:setCollisionClass('Entity')

    return entity
end

function Entity:reset()
    self.collider:setPosition(self.startX + 5, self.startY + 100)
    self.collider:setLinearVelocity(0, 0)
end

function Entity:draw()
    colliderDraw(self.collider)
end

return Entity