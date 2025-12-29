function love.load()
    wf = require "libraries/windfield"
    Entity = require "Entity"
    Ball = require "Ball"
    Wall = require "Wall"
    BlockWall = require "BlockWall"

    gameStop = false
    debug = false

    world = wf.newWorld(0, 500, true)
    world:setGravity(0, 500)

    world:addCollisionClass('Ball')
    world:addCollisionClass('Entity', {ignores = {'Ball'}})
    world:addCollisionClass('Wall', {ignores = {'Ball'}})
    world:addCollisionClass('BlockWall', {ignores = {'Ball'}})

    player = Entity:new(0, 400, 200, world)
    player2 = Entity:new(790, 400, 200, world)

    ball = Ball:new(world)

    leftWin = BlockWall:new(-2, 10, 1, 600, world)
    rightWin = BlockWall:new(802, 0, 1, 600, world)

    leftStuck = BlockWall:new(11, 0, 1, 600, world)
    rightStuck = BlockWall:new(789, 0, 1, 600, world)

    top = Wall:new(0, -1, 800, 1, world)
    ground = Wall:new(0, 601, 800, 1, world)
end

function love.update(dt)
    if not gameStop then
        ball:touch()
        player:fJumpCooldown(dt)
        player2:fJumpCooldown(dt)

        world:update(dt)
    end
end

function love.draw()
    if debug then
        world:draw()
    else
        player:draw()
        player2:draw()
        ball:draw()
        colliderDraw(ground)
    end
end

function love.keypressed(key)
    -- Key for the game
    if key == "escape" then
        gameStop = not gameStop
    end
    if key == "o" then
        debug = not debug
    end
    if key == "r" then
        restartGame()
    end

    -- Key for the player 1
    if key == "space" then
        player:jump()
    end
    if key == "p" then
        player.collider:setRestitution(1.5)
    end
    if key == "m" then
        player.collider:setRestitution(0.5)
    end

    -- Key for the player 2
    if key == "z" then
        player2:jump()
    end
end

function colliderDraw(collider)
    local x1, y1, x2, y2 = collider:getBoundingBox()
    love.graphics.rectangle("fill", x1, y1, x2 - x1, y2 - y1)
end

function restartGame()
    player:reset()
    player2:reset()
    ball:reset()
end