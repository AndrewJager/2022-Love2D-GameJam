
local utils = {}
utils.sceneScripter = require("scenescripter")
utils.clickableArea = require("clickablearea")

local manager = require("scenemanager")

function love.load()
    love.window.setMode(1000, 700)

    manager.load(utils)
    manager.addScene(require("outsidebefore"))
    manager.setScene("Outside-Before")
end

function love.update(dt)
    manager.update(dt)    
end

function love.draw()
    manager.draw()    
end

function love.mousemoved(x, y, dx, dy, istouch)
    manager.mousemoved(x, y)
end

function love.mousepressed(x, y, button, istouch)
    manager.mousepressed(x, y)
end