local scene = require("scenescripter")
local test = "0"

function love.load()
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
    scene.update(dt)
end

function love.draw()
    love.graphics.print(test, 10, 10)
    scene.draw()
end