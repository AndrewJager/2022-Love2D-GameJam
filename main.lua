local sceneScripter = require("scenescripter")
local clickableArea = require("clickablearea")

local scene = sceneScripter.buildScene()

local clickA = clickableArea.buildArea()
local clickB = clickableArea.buildArea()
local test = "0"

function love.load()
    local function d()
        test = "4"
    end
    clickA.load(200, 50, 80, 80, d, "")
    clickB.load(200, 150, 80, 80, d, "Testing hover text")
    scene.load()
    local function a()
        test = "1"
    end
    local function b()
        test = "2"
    end
    local function c()
        test = "3"
    end

    scene.addEvent(a, 1)
    scene.addEvent(b, 2)
    scene.addEvent(c, 4)
    scene.start()
end

function love.update(dt)
    scene.update()
end

function love.draw()
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print(test, 10, 10)
    scene.draw()
    clickA.draw()
    clickB.draw()
end

function love.mousemoved(x, y, dx, dy, istouch)
    clickA.mousemoved(x, y)
    clickB.mousemoved(x, y)
end

function love.mousepressed(x, y, button, istouch)
    clickA.mousepressed(x, y)
    clickB.mousepressed(x, y)
end