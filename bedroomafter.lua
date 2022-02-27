local a = {}

a.load = function(utils)
    a.name = "Bedroom-After"
    a.background = love.graphics.newImage("img/bedroom-after.png")

    local function exitRoom()
        utils.manager.setScene("Living-After")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(620, 90, 110, 360, exitRoom, "Door")

    local function window()
        utils.manager.setScene("Outside-After")
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(165, 80, 110, 180, window, "Window")

    local function bed()

    end
    a.bed = utils.clickableArea.buildArea()
    a.bed.load(150, 340, 370, 145, bed, "Bed")
end

a.update = function()
   
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.draw(a.background, 98, 30)

    a.door.draw()
    a.bed.draw()
    a.window.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.bed.mousemoved(x, y)
    a.window.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.bed.mousepressed(x, y)
    a.window.mousepressed(x, y)
end

return a