local a = {}

a.load = function(utils)
    a.name = "Outside-Before"
    a.background = love.graphics.newImage("img/outside-before.png")

    local function enterDoor()
        utils.manager.setScene("Living-Before")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(470, 230, 70, 165, enterDoor, "Enter house")

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
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
end

return a