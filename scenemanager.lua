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
    a.pillow = makeItem("Pillow", love.graphics.newImage("img/items/pillow.png"), "Living-After", 1.05, false, 0, 15)
    a.ladder = makeItem("Ladder", love.graphics.newImage("img/items/ladder.png"), "Basement-Before", 0.14, false, 20, 2)
    a.hammer = makeItem("Sledgehammer", love.graphics.newImage("img/items/sledgehammer.png"), "Basement-Before", 0.15, true, 50, 5)
    a.shovel = makeItem("Shovel", love.graphics.newImage("img/items/shovel.png"), "Basement-Before", 0.14, true, 60, 0)
    a.picture = makeItem("Missing Picture", love.graphics.newImage("img/items/picture.png"), "Living-After", 0.26, true, 36, 2)

    a.backBefore = love.graphics.newImage("img/background/before.jpg")

    a.talkFont = love.graphics.newFont("font/Architects_Daughter/ArchitectsDaughter-Regular.ttf", 15)
    a.cleanFont = love.graphics.newFont("font/Source_Code_Pro/SourceCodePro-Medium.ttf", 20)

    a.scenes = {}
    a.selectedScene = nil
    a.nextScene = nil
    a.utils = utils

    a.curItem = nil
    a.itemSelected = false

    a.startTime = 0
    a.switching = false
    a.switchingB = false
    a.swtichAmt = 0
    a.passed = 0

    local function makeDialog()
        local d = {}
        d.text = ""
        table.insert(a.dialog, d)
    end
    a.dialog = {}
    a.dTimePassed = 0
    a.dStartTime = 0
    makeDialog()
    makeDialog()
    makeDialog()
    makeDialog()
    makeDialog()
    makeDialog()
    a.feedback = ""

    a.itemX = 630
    a.itemY = 600
    a.itemW = 80
    a.itemH = 80

    -- goals
    a.readnote = false
    a.viewedpictures = false
    a.picturePlaced = false
    a.dreamed = false
end

a.update = function(dt)
    a.selectedScene.scene.update(dt)

    if a.switching then
        a.passed = (love.timer.getTime() - a.startTime) 
        a.swtichAmt = a.passed
        if a.passed >= 0.5 then
            a.switching = false
            a.selectedScene = a.nextScene
            a.switchingB = true
            a.startTime = love.timer.getTime()
            a.passed = 0
        end
    end
    if a.switchingB then
        a.passed = love.timer.getTime() - a.startTime
        a.swtichAmt = a.passed
        if a.passed >= 0.5 then
            a.switchingB = false
        end
    end

    if a.dTimePassed < 1 then
        a.dTimePassed = love.timer.getTime() - a.dStartTime
    end
end

a.draw = function()
    a.selectedScene.scene.draw()


    if not (a.selectedScene.name == "Intro") then
        love.graphics.setLineWidth(1)
        love.graphics.setLineJoin("bevel")
        love.graphics.setColor(0, 0, 0.8, 1)
        love.graphics.rectangle("line", 110, 550, 500, 130)
        love.graphics.setFont(a.talkFont)
        love.graphics.print(a.dialog[1], 115, 555)
        love.graphics.print(a.dialog[2], 115, 575)
        love.graphics.print(a.dialog[3], 115, 595)
        love.graphics.print(a.dialog[4], 115, 615)
        love.graphics.print(a.dialog[5], 115, 635)
        love.graphics.setColor(0, 0, 0.8, a.dTimePassed)
        love.graphics.print(a.dialog[6], 115, 655)

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

        if a.switching then
            love.graphics.push("all")
            love.graphics.setColor(0.8, 0.8, 0.8, a.passed * 2)
            love.graphics.rectangle("fill", 0, 0, 1000, 700)
            love.graphics.pop()
        end
        if a.switchingB then
            love.graphics.push("all")
            love.graphics.setColor(0.8, 0.8, 0.8, 1 - a.passed * 2)
            love.graphics.rectangle("fill", 0, 0, 1000, 700)
            love.graphics.pop()
        end
    end
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

a.setScene = function(sceneName, force)
    if force then
        for i = 1, #a.scenes do
            if a.scenes[i].name == sceneName then
                a.selectedScene = a.scenes[i]
                a.feedback = ""
                a.startTime = love.timer.getTime()
                break
            end
        end
    else
        for i = 1, #a.scenes do
            if a.scenes[i].name == sceneName then
                a.nextScene = a.scenes[i]
                a.feedback = ""
                a.startTime = love.timer.getTime()
                a.switching = true
                break
            end
        end
    end
end

a.addDialog = function(text)
    a.dialog[1] = a.dialog[2]
    a.dialog[2] = a.dialog[3]
    a.dialog[3] = a.dialog[4]
    a.dialog[4] = a.dialog[5]
    a.dialog[5] = a.dialog[6]
    a.dialog[6] = text
    a.dTimePassed = 0
    a.dStartTime = love.timer.getTime()
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