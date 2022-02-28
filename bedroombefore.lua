local a = {}

a.load = function(utils)
    a.name = "Bedroom-Before"
    a.manager = utils.manager
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
end

a.update = function()
   
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.draw(a.background, 98, 30)

    a.door.draw()
    a.bed.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.bed.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.bed.mousepressed(x, y)
end

return a