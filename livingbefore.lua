local a = {}

a.load = function(utils)
    a.name = "Living-Before"
    a.manager = utils.manager
    a.back = utils.manager.backBefore
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
        if not a.manager.viewedpictures then
            utils.manager.addDialog("Family pictures. Mostly peoplle I never really knew. One is missing")
        elseif not a.manager.dreamed then
            utils.manager.addDialog("Maybe you can find the missing picture somewhere?")
        end
        utils.manager.viewedpictures = true
    end
    a.pictures = utils.clickableArea.buildArea()
    a.pictures.load(375, 85, 280, 170, pictures, "Pictures")

    local function basement()
        utils.manager.setScene("Basement-Before") 
    end
    a.basement = utils.clickableArea.buildArea()
    a.basement.load(240, 405, 140, 85, basement, "Basement Stairs")

    local delay = a.manager.textDelay
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("It's a small home, but it was our home")
        end, 0.5 * delay)

    a.afterScript = utils.sceneScripter.buildScene()
    a.afterScript.load()
    a.afterScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("At least I didn't have to face this alone")
        end, 0.5 * delay)
end

a.update = function()
    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update()

    if a.manager.dreamed and (not a.afterStarted) then 
        a.afterScript.start()
        a.bedroomDoor.func = function() a.manager.feedback = a.manager.ending end
        a.afterStarted = true
    end
    a.afterScript.update()
end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

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