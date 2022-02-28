local a = {}

a.load = function(utils)
    a.name = "Outside-After"
    a.manager = utils.manager
    a.background = love.graphics.newImage("img/outside-after.png")
    a.noteImg = love.graphics.newImage("img/items/note.png")
    a.rackImg = love.graphics.newImage("img/items/rack.png")

    local function enterDoor()
        
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(420, 270, 100, 165, enterDoor, "Door")
    a.treeImg = love.graphics.newImage("img/tree-after.png")

    local function window()
        utils.manager.setScene("Bedroom-After")
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(120, 225, 60, 95, window, "Window")

    local function switch()
        if a.manager.curItem == nil then
            utils.manager.setScene("Outside-Before")
        else
            a.manager.feedback = "You cannot switch times while holding an item"
        end
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "Swap to the Before")

    local function tree()
        a.manager.areaHandler(a.manager.ladder, "Outside", a.tree, "Tree", "Ladder") 
    end
    a.tree = utils.clickableArea.buildArea()
    a.tree.load(790, 150, 80, 300, tree, "Tree")

    a.noteScript = utils.sceneScripter.buildScene()
    a.noteScript.load()
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "#################################################"
    ) end, 0.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "# Sometimes, it feels like everything has fallen apart                              #"
    ) end, 1.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "# But if you can find something that was missing before                                 #"
    ) end, 2.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "# Then at least one thing is better than it was before                              #"
    ) end, 3.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "#################################################"
    ) end, 4.5)
    a.noteScript.addEvent(function() a.manager.readnote = true end, 4.5)
    local function note()
        if a.manager.ladder.loc == "Outside" then
            a.noteScript.start()
        else
            a.manager.feedback = "You can't reach it"
        end
    end
    a.note = utils.clickableArea.buildArea()
    a.note.load(800, 73, 60, 70, note, "Note")

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
    a.noteScript.update()
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
    love.graphics.translate(a.note.x + 15, a.note.y)
    love.graphics.scale(0.3, 0.3)
    love.graphics.rotate(math.rad(15))
    love.graphics.draw(a.noteImg)
    love.graphics.pop()

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
    a.window.draw()
    a.tree.draw()
    a.note.draw()
    a.hRack.draw()
    a.sRack.draw()
end

a.mousemoved = function(x, y)
    a.door.mousemoved(x, y)
    a.switch.mousemoved(x, y)
    a.window.mousemoved(x, y)
    a.tree.mousemoved(x, y)
    a.note.mousemoved(x, y)
    a.hRack.mousemoved(x, y)
    a.sRack.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.door.mousepressed(x, y)
    a.switch.mousepressed(x, y)
    a.window.mousepressed(x, y)
    a.tree.mousepressed(x, y)
    a.note.mousepressed(x, y)
    a.hRack.mousepressed(x, y)
    a.sRack.mousepressed(x, y)
end

return a