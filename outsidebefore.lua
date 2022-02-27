local a = {}

a.load = function(utils)
    a.name = "Outside-Before"
    a.background = love.graphics.newImage("img/outside-before.png")

    local function enterDoor()
        utils.manager.setScene("Living-Before")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(470, 230, 70, 165, enterDoor, "Enter house")

    local function switch()
        utils.manager.setScene("Outside-After")
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "Swap to the After")

    -- a.introScript = utils.sceneScripter.buildScene()



    -- a.introScript.addEvent(aa, 1)
    -- a.introScript.addEvent(b, 2)
    -- a.introScript.addEvent(c, 4)
    -- a.introScript.start()
end

a.update = function()
    
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.push()
    love.graphics.scale(0.7, 0.7)
    love.graphics.draw(a.background, 100, 30)
    love.graphics.pop()

    a.door.draw()
    a.switch.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.switch.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.switch.mousepressed(x, y)
end

return a