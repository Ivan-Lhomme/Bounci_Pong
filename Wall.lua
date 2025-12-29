Wall = {}
Wall.__index = Wall

function Wall:new(x, y, width, height, world)
    local wall = world:newRectangleCollider(x, y, width, height)
    wall:setType('static')
    wall:setCollisionClass('Wall')

    return wall
end

return Wall