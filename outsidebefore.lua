local a = {}

a.load = function(utils)
    a.name = "Outside-Before"
    a.manager = utils.manager
    a.background = love.graphics.newImage("img/outside-before.png")
    a.treeImg = love.graphics.newImage("img/tree-before.png")
    a.rackImg = love.graphics.newImage("img/items/rack.png")

    local function enterDoor()
        utils.manager.setScene("Living-Before")
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(470, 230, 70, 165, enterDoor, "Enter house")

    local function switch()
        if a.manager.curItem == nil then
            utils.manager.setScene("Outside-After")
        else
            a.manager.feedback = "You cannot switch times while holding an item"
        end
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "Swap to the After")

    local function tree()
        a.manager.areaHandler(a.manager.ladder, "Outside", a.tree, "Tree", "Ladder")
    end
    a.tree = utils.clickableArea.buildArea()
    a.tree.load(790, 150, 80, 300, tree, "Tree")

    local function hammerRack()
        a.manager.areaHandler(a.manager.hammer, "Outside", a.tree, "Storage - Sledgehammer", "Sledgehammer")
    end
    a.hRack = utils.clickableArea.buildArea()
    a.hRack.load(600, 300, 50, 110, hammerRack, "Storage - Sledgehammer")

    local function shovelRack()
        a.manager.areaHandler(a.manager.shovel, "Outside", a.tree, "Storage - Shovel", "Shovel")
    end
    a.sRack = utils.clickableArea.buildArea()
    a.sRack.load(660, 270, 50, 140, shovelRack, "Storage - Shovel")
end

a.update = function()
    
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.push()
    love.graphics.scale(0.7, 0.7)
    love.graphics.draw(a.background, 100, 30)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.scale(0.6, 0.6)
    love.graphics.draw(a.treeImg, 1050, 0)
    love.graphics.pop()

    local ladder = a.manager.ladder
    if (ladder.loc == "Outside") then
        love.graphics.push()
        love.graphics.translate(a.tree.x -40, a.tree.y + 2)
        love.graphics.scale(0.5, 0.5)
        love.graphics.draw(ladder.img)
        love.graphics.pop()
    end

    love.graphics.push()
    love.graphics.translate(575, 320)
    love.graphics.scale(0.6, 0.6)
    love.graphics.draw(a.rackImg)
    love.graphics.pop()
    local hammer = a.manager.hammer
    if (hammer.loc == "Outside") then
        love.graphics.push()
        love.graphics.translate(a.hRack.x + 5, a.hRack.y + 5)
        love.graphics.scale(0.2, 0.2)
        love.graphics.draw(hammer.img)
        love.graphics.pop()
    end
    local shovel = a.manager.shovel
    if (shovel.loc == "Outside") then
        love.graphics.push()
        love.graphics.translate(a.sRack.x + 10, a.sRack.y + 2)
        love.graphics.scale(0.2, 0.2)
        love.graphics.draw(shovel.img)
        love.graphics.pop()
    end

    a.door.draw()
    a.switch.draw()
    a.tree.draw()
    a.hRack.draw()
    a.sRack.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.switch.mousemoved(x, y)
    a.tree.mousemoved(x, y)
    a.hRack.mousemoved(x, y)
    a.sRack.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.switch.mousepressed(x, y)
    a.tree.mousepressed(x, y)
    a.hRack.mousepressed(x, y)
    a.sRack.mousepressed(x, y)
end

return a