local a = {}

a.load = function(utils)
    local function makeItem(name, img, initLoc, scale, rot45, offsetX, offsetY) 
        local item = {}
        item.name = name
        item.img = img
        item.loc = initLoc
        item.scale = scale
        item.rot45 = rot45
        item.offsetX = offsetX
        item.offsetY = offsetY
        table.insert(a.items, item)
        return item
    end
    a.items = {}
    a.pillow = makeItem("Pillow", love.graphics.newImage("img/items/pillow.png"), "Living-After", 1.05, false, 0, 0)
    a.ladder = makeItem("Ladder", love.graphics.newImage("img/items/ladder.png"), "Basement-Before", 0.14, false, 20, 2)
    a.hammer = makeItem("Sledgehammer", love.graphics.newImage("img/items/sledgehammer.png"), "Basement-Before", 0.15, true, 50, 5)
    a.shovel = makeItem("Shovel", love.graphics.newImage("img/items/shovel.png"), "Basement-Before", 0.14, true, 60, 0)

    a.scenes = {}
    a.selectedScene = nil
    a.utils = utils

    a.curItem = nil
    a.itemSelected = false

    a.d1 = "Hello"
    a.d2 = "Two"
    a.d3 = "Three"
    a.d4 = "Four"
    a.d5 = "Five"
    a.d6 = "Six"
    a.feedback = "Cats are evil"

    a.itemX = 630
    a.itemY = 600
    a.itemW = 80
    a.itemH = 80

    -- goals
    a.readnote = false
    a.viewedpictures = false
end

a.update = function(dt)
    a.selectedScene.scene.update()
end

a.draw = function()
    a.selectedScene.scene.draw()

    love.graphics.setLineWidth(1)
    love.graphics.setLineJoin("bevel")
    love.graphics.setColor(0, 0, 0.8, 1)
    love.graphics.rectangle("line", 110, 550, 500, 130)
    love.graphics.print(a.d1, 115, 555)
    love.graphics.print(a.d2, 115, 575)
    love.graphics.print(a.d3, 115, 595)
    love.graphics.print(a.d4, 115, 615)
    love.graphics.print(a.d5, 115, 635)
    love.graphics.print(a.d6, 115, 655)

    if a.itemSelected then
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.rectangle("line", a.itemX, a.itemY, a.itemW, a.itemH)
    if a.curItem ~= nil then
        love.graphics.push()
        love.graphics.translate(635, 600)
        love.graphics.translate(a.curItem.offsetX, a.curItem.offsetY)
        love.graphics.scale(a.curItem.scale, a.curItem.scale)
        if a.curItem.rot45 then
            love.graphics.rotate(math.rad(45))
        end
        love.graphics.draw(a.curItem.img)
        love.graphics.pop()
    end

    love.graphics.setColor(0.8, 0, 0, 1)
    love.graphics.rectangle("line", 630, 550, 350, 20)
    love.graphics.print(a.feedback, 635, 553)
end

a.mousemoved = function(x, y)
    a.selectedScene.scene.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.selectedScene.scene.mousepressed(x, y)

    if (x > a.itemX and (x < (a.itemX + a.itemW)))
        and (y > a.itemY and (y < (a.itemY + a.itemH))) then
        a.itemSelected = not a.itemSelected        
    end
end

a.addScene = function(scene)
    scene.load(a.utils)
    table.insert(a.scenes, {name=scene.name, scene=scene})
end

a.setScene = function(sceneName)
    for i = 1, #a.scenes do
        if a.scenes[i].name == sceneName then
            a.selectedScene = a.scenes[i]
            a.feedback = ""
            break
        end
    end
end

a.addDialog = function(text)
    a.d1 = a.d2
    a.d2 = a.d3
    a.d3 = a.d4
    a.d4 = a.d5
    a.d5 = a.d6
    a.d6 = text
end

a.setCurItem = function(item)
    local added = false
    if (a.curItem == nil) then
        a.curItem = item
        item.loc = "Held"
        a.feedback = "Picked up " .. item.name
        added = true
    else
        a.feedback = "You are already holding an item!"
    end

    return added
end

a.dropCurItem = function()
    if a.curItem ~= nil then
        a.feedback = "Dropped " .. a.curItem.name
        a.curItem = nil
        a.itemSelected = false
    end
end

a.getItem = function(name) 
    for i = 1, #a.items do
        if a.items[i].name == name then
            return a.items[i]
        end
    end
end

a.areaHandler = function(item, locName, clickArea, hoverNoItem, hoverItem)
    if item.loc == locName then
        a.setCurItem(item)
        clickArea.hovertext = hoverNoItem
    elseif (a.curItem ~= nil) and (a.curItem.name == item.name) and a.itemSelected then
        item.loc = locName
        a.dropCurItem()
        clickArea.hovertext = hoverItem
    elseif (a.curItem ~= nil) and a.itemSelected then
        a.feedback = "Cannot do that"
    end
end

return a