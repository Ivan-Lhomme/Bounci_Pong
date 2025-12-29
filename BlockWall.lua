BlockWall = {}
BlockWall.__index = BlockWall

function BlockWall:new(x, y, width, height, world)
    local blockWall = world:newRectangleCollider(x, y, width, height)
    blockWall:setType('static')
    blockWall:setCollisionClass('BlockWall')

    return blockWall
end

return BlockWall