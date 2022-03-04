local a = {}

a.load = function(utils)
    a.name = "Outside-Before"
    a.manager = utils.manager
    a.back = utils.manager.backBefore
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
            a.manager.feedback = "You cannot shift while holding an item"
        end
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "After")

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

    local delay = a.manager.textDelay
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("I remember how safe this place felt")
        end, 0.5 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("How nothing bad could ever happen here")
        end, 1 * delay)

    a.afterScript = utils.sceneScripter.buildScene()
    a.afterScript.load()
    a.afterScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("We just have to pick up the pieces and put them back together")
        end, 1 * delay)
end

a.update = function()
    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update()

    if a.manager.dreamed and (not a.afterStarted) then 
        a.afterScript.start()
        a.switch.func = function() a.manager.feedback = a.manager.ending end
        a.afterStarted = true
    end
    a.afterScript.update()
end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

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

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("line", a.switch.x, a.switch.y, a.switch.width, a.switch.height)
    local switchImg = a.manager.switchImg
    love.graphics.push()
    love.graphics.translate(a.switch.x + 2, a.switch.y + 2)
    love.graphics.scale(0.25, 0.25)
    love.graphics.draw(switchImg)
    love.graphics.pop()

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