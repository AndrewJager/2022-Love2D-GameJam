
local utils = {}
utils.sceneScripter = require("scenescripter")
utils.clickableArea = require("clickablearea")

local manager = require("scenemanager")
utils.manager = manager

function love.load()
    love.window.setMode(1000, 700)

    manager.load(utils)
    manager.addScene(require("outsidebefore"))
    manager.addScene(require("livingbefore"))
    manager.addScene(require("bedroombefore"))
    manager.addScene(require("basementbefore"))
    manager.addScene(require("outsideafter"))
    manager.addScene(require("bedroomafter"))
    manager.addScene(require("livingafter"))
    manager.setScene("Outside-Before", true)
    -- manager.setScene("Living-After")
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