local a = {}

a.load = function(utils)
    a.name = "Outside-After"
    a.background = love.graphics.newImage("img/outside-after.png")

    local function enterDoor()
        
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(420, 270, 100, 165, enterDoor, "Door")

    local function window()
        utils.manager.setScene("Bedroom-After")
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(120, 225, 60, 95, window, "Window")

    local function switch()
        utils.manager.setScene("Outside-Before")
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "Swap to the Before")
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
    a.window.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.switch.mousemoved(x, y)
    a.window.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.switch.mousepressed(x, y)
    a.window.mousepressed(x, y)
end

return a