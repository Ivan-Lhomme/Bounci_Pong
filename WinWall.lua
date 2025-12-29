WinWall = {}
WinWall.__index = WinWall

function WinWall:new(x, y, width, height, world)
    local winWall = world:newRectangleCollider(x, y, width, height)
    winWall:setType('kinematic')
    winWall:setCollisionClass('WinWall')

    return winWall
end

return WinWall