
local utils = {}
utils.sceneScripter = require("scenescripter")
utils.clickableArea = require("clickablearea")

local manager = require("scenemanager")
utils.manager = manager

local moonshine = require("lib/moonshine")
utils.moonshine = moonshine

function love.load()
    love.window.setMode(1000, 700)
    love.window.setTitle("Fragments")

    manager.load(utils)
    manager.addScene(require("outsidebefore"))
    manager.addScene(require("livingbefore"))
    manager.addScene(require("bedroombefore"))
    manager.addScene(require("basementbefore"))
    manager.addScene(require("outsideafter"))
    manager.addScene(require("bedroomafter"))
    manager.addScene(require("livingafter"))
    manager.addScene(require("intro"))
    manager.addScene(require("intro2"))
    manager.addScene(require("title"))

    manager.setScene("Intro-2", true)

    manager.effect = moonshine(moonshine.effects.vignette)
        -- .chain(moonshine.effects.gaussianblur)
    manager.effect.vignette.opacity = 0.2
    -- manager.effect.godsray.exposure = 0.1
end

function love.update(dt)
    manager.update(dt)    
end

function love.draw()
    -- manager.draw()
    manager.effect(function()
        manager.draw()
    end)
end

function love.mousemoved(x, y, dx, dy, istouch)
    manager.mousemoved(x, y)
end

function love.mousepressed(x, y, button, istouch)
    manager.mousepressed(x, y)
end