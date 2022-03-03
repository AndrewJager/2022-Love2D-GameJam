local a = {}

a.load = function(utils)
    a.name = "Bedroom-Before"
    a.manager = utils.manager
    a.back = utils.manager.backBefore
    a.background = love.graphics.newImage("img/bedroom-before.png")

    local function exitRoom()
        utils.manager.setScene("Living-Before")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(620, 90, 110, 360, exitRoom, "Exit room")

    local function bed()
        if a.manager.picturePlaced then
            a.manager.feedback = "You don't want to sleep here. Too many memories."
        else
            a.manager.feedback = "You have no reason to sleep now"
        end
    end
    a.bed = utils.clickableArea.buildArea()
    a.bed.load(150, 340, 370, 145, bed, "Bed")

    local function window()
        a.manager.addDialog("I always used to be afraid that someone would use this to climb inside")
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(165, 80, 110, 180, window, "Window")

    local delay = 0.1
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("This was my room. Nothing else to say, really")
        end, 1 * delay)
end

a.update = function()
    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update() 
end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()
    
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