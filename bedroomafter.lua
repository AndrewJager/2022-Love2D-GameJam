local a = {}

a.load = function(utils)
    a.name = "Bedroom-After"
    a.background = love.graphics.newImage("img/bedroom-after.png")
    a.doorImg = love.graphics.newImage("img/items/bedroom-door.png")
    a.back = utils.manager.backAfter

    a.doorBroken = false
    a.pillowPlaced = false
    a.manager = utils.manager

    local function door()
        if a.doorBroken then
            utils.manager.setScene("Living-After")
        elseif (a.manager.curItem ~= nil) and (a.manager.curItem.name == "Sledgehammer") 
            and a.manager.itemSelected then
            a.doorBroken = true
        else
            a.manager.feedback = "The door is jammed"
        end
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(620, 90, 110, 360, door, "Door")

    local function window()
        utils.manager.setScene("Outside-After")
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(165, 80, 110, 180, window, "Window")

    local function bed()
        if (a.manager.curItem ~= nil) and (a.manager.curItem.name == "Pillow") 
            and a.manager.itemSelected then
                a.pillowPlaced = true
                a.manager.dropCurItem()
        elseif a.manager.picturePlaced then
            if a.pillowPlaced then
                a.manager.dreamed = true
            else
                a.manager.feedback = "You don't want to sleep without a pillow"
            end
        else
            a.manager.feedback = "You have no reason to sleep now"
        end
    end
    a.bed = utils.clickableArea.buildArea()
    a.bed.load(150, 340, 370, 145, bed, "Bed")
end

a.update = function(dt)

end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

    love.graphics.draw(a.background, 98, 30)

    if not a.doorBroken then
        love.graphics.draw(a.doorImg, a.door.x, a.door.y)
    else
        love.graphics.rectangle("line", a.door.x, a.door.y, a.door.width, a.door.height)
    end

    if a.pillowPlaced then
        love.graphics.push()
        love.graphics.translate(170, 360)
        love.graphics.rotate(math.rad(35))
        love.graphics.draw(a.manager.pillow.img)
        love.graphics.pop()
    end

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