local a = {}

a.load = function(utils)
    a.name = "Living-Before"
    a.background = love.graphics.newImage("img/living-before.png")

    local function exitHouse()
        utils.manager.setScene("Outside-Before")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(750, 150, 130, 340, exitHouse, "Exit house")

    local function enterRoom()
        utils.manager.setScene("Bedroom-Before")
    end
    a.bedroomDoor = utils.clickableArea.buildArea()
    a.bedroomDoor.load(100, 155, 85, 310, enterRoom, "Bedroom")

    local function pictures()
        
    end
    a.pictures = utils.clickableArea.buildArea()
    a.pictures.load(375, 85, 280, 170, pictures, "Pictures")

    local function basement()
        utils.manager.setScene("Basement-Before") 
    end
    a.basement = utils.clickableArea.buildArea()
    a.basement.load(240, 405, 140, 85, basement, "Basement Stairs")
end

a.update = function()
   
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.push()
    love.graphics.scale(0.85, 0.85)
    love.graphics.draw(a.background, 98, 30)
    love.graphics.pop()

    a.door.draw()
    a.bedroomDoor.draw()
    a.pictures.draw()
    a.basement.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.bedroomDoor.mousemoved(x, y)
    a.pictures.mousemoved(x, y)
    a.basement.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.bedroomDoor.mousepressed(x, y)
    a.pictures.mousepressed(x, y)
    a.basement.mousepressed(x, y)
end

return a