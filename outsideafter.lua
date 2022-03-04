local a = {}

a.load = function(utils)
    a.name = "Outside-After"
    a.manager = utils.manager
    a.back = utils.manager.backAfter
    a.background = love.graphics.newImage("img/outside-after.png")
    a.noteImg = love.graphics.newImage("img/items/note.png")
    a.rackImg = love.graphics.newImage("img/items/rack.png")
    a.font = love.graphics.newFont("font/Dokdo/Dokdo-Regular.ttf", 200)
    a.cleanFont = love.graphics.newFont("font/Architects_Daughter/ArchitectsDaughter-Regular.ttf", 25)

    local function enterDoor()
        a.manager.feedback = "It won't open"
    end
    a.door = utils.clickableArea.buildArea()
    a.door.load(420, 270, 100, 165, enterDoor, "Door")
    a.treeImg = love.graphics.newImage("img/tree-after.png")

    a.ready = false
    local function window()
        a.manager.feedback = "Not yet"
    end
    a.window = utils.clickableArea.buildArea()
    a.window.load(120, 225, 60, 95, window, "Window")

    local function switch()
        if a.manager.curItem == nil then
            utils.manager.setScene("Outside-Before")
        else
            a.manager.feedback = "You cannot shift while holding an item"
        end
    end
    a.switch = utils.clickableArea.buildArea()
    a.switch.load(15, 600, 80, 80, switch, "Before")
    a.switch.enabled = false

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
        "# Sometimes, it feels like everything has fallen apart                   #"
    ) end, 1.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "# But if you can find something that was missing before              #"
    ) end, 2.5)
    a.noteScript.addEvent(
        function() a.manager.addDialog(
        "# Then at least one thing is better than it was before                  #"
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
    a.switchTime = 0
    a.switchTimePassed = 0

    local delay = a.manager.textDelay
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function() 
            a.manager.clearDialog()
        end, 0)
    a.introScript.addEvent(function()
            a.manager.addDialog("I need you to find something... something that matters")
        end, 1 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("I'm not sure exactly what. We'll figure it out as we go")
        end, 2 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("Click on something to interact with it")
        end, 4 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("If you find an object, you can pick it up")
        end, 5 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("Click on the object in your inventory to select it")
        end, 6 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("Clicking on something with an object selected will use the object")
        end, 7 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("And finally, use the button on the left to shift between then and now")
            a.switch.enabled = true
            a.switchTime = love.timer.getTime()
        end, 8 * delay)
    a.introScript.addEvent(function()
            a.manager.addDialog("It is only possible to shift while outside")
            a.window.func = function() 
                if a.manager.beenInRoom then
                    a.manager.setScene("Bedroom-After") 
                else
                    a.manager.addDialog("Not yet. Let's come back later")
                end
            end
        end, 9 * delay)

    a.afterScript = utils.sceneScripter.buildScene()
    a.afterScript.load()
    a.afterScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("Some events are inevitable")
        end, 1 * delay)

    a.dark = false
    a.darkStart = 0
    a.darkTime = 0
    a.finalText = false
    a.finalStart = 0
    a.finalTime = 0
    a.finalText2 = false
    a.finalStart2 = 0
    a.finalTime2 = 0
    a.ended = false
    a.xAmt = 0
    a.flip = false
    local function addText(text, x, y)
        local newText = {}
        newText.text = text
        newText.x = x
        newText.y = y
        newText.timePassed = 0
        newText.fadeTime = 0.5
        table.insert(a.text, newText)
    end
    a.text = {}
    a.endScript = utils.sceneScripter.buildScene()
    a.endScript.load()
    a.endScript.addEvent(function()
        a.dark = true
        a.manager.drawUI = false
        a.switch.enabled = false
        a.door.enabled = false
        a.hRack.enabled = false
        a.sRack.enabled = false
        a.note.enabled = false
        a.tree.enabled = false
        a.window.enabled = false
        a.flip = false
    end, 0)
    a.endScript.addEvent(function()
            a.darkStart = love.timer.getTime()
        end, 3)
    a.endScript.addEvent(function()
        a.finalText = true
        a.finalStart = love.timer.getTime()
    end, 6)
    a.endScript.addEvent(function()
        a.finalText2 = true
        a.finalStart2 = love.timer.getTime()
    end, 10)
    a.endScript.addEvent(function()
        a.ended = true
    end, 14)
    a.endScript.addEvent(function()
        a.flip = true
    end, 22.3)
    a.endScript.addEvent(function()
        a.flip = false
    end, 22.7)
    a.endScript.addEvent(function()
        addText("Developed by starandsnow for the 2022 LÖVE Jam", 1600, 350)
    end, 23)
    a.endScript.addEvent(function()
        a.flip = true
    end, 23.6)
    a.endScript.addEvent(function()
        a.flip = false
    end, 24)
    a.endScript.addEvent(function()
        addText("Thanks to pablomayobre for running the game jam!", 1600, 450)
    end, 25)
    a.endScript.addEvent(function()
        a.flip = true
    end, 25.7)
    a.endScript.addEvent(function()
        a.flip = false
    end, 26)
    a.endScript.addEvent(function()
        a.flip = true
    end, 26.5)
    a.endScript.addEvent(function()
        a.flip = false
    end, 26.8)
    a.endScript.addEvent(function()
        addText("Thank you for playing!", 1750, 600)
    end, 27)
    a.endScript.addEvent(function()
        a.flip = true
    end, 28)
    a.endScript.addEvent(function()
        a.flip = false
    end, 28.4)
    a.endScript.addEvent(function()
        a.flip = true
    end, 30)
    a.endScript.addEvent(function()
        a.flip = false
    end, 33)
end

a.update = function(dt)
    a.noteScript.update()
    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update()

    if a.manager.dreamed and (not a.afterStarted) then 
        a.afterScript.start()
        a.door.func = function() a.manager.feedback = a.manager.ending end
        a.window.func = function() a.manager.feedback = a.manager.ending end
        a.afterStarted = true
    end
    a.afterScript.update()

    if a.manager.broken and (not a.endStarted) then
        a.endScript.start()
        a.endStarted = true
        a.dark = true
    end
    a.endScript.update()

    if a.switch.enabled and (a.switchTimePassed < 1) then
        a.switchTimePassed = love.timer.getTime() - a.switchTime
    end

    if (a.dark == true) and (a.darkStart ~= 0) and (a.darkTime < 4) then
        a.darkTime = love.timer.getTime() - a.darkStart
    end

    if a.finalText and (a.finalStart ~= 0) and (a.finalTime < 1) then
        a.finalTime = love.timer.getTime() - a.finalStart
    end
    if a.finalText2 and (a.finalStart2 ~= 0) and (a.finalTime2 < 1) then
        a.finalTime2 = love.timer.getTime() - a.finalStart2
    end

    if a.ended and (a.xAmt > -1400) then
        a.xAmt = a.xAmt - (dt * 200)
    end

    for i=1, #a.text do
        if a.text[i].timePassed <= a.text[i].fadeTime then
            a.text[i].timePassed = a.text[i].timePassed + dt
        end
    end
end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

    love.graphics.push()
    if a.ended then
        love.graphics.translate(a.xAmt, 0)
    end
    
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

    if a.switch.enabled then
        love.graphics.setColor(0, 0, 0, a.switchTimePassed)
        love.graphics.rectangle("line", a.switch.x, a.switch.y, a.switch.width, a.switch.height)
        local switchImg = a.manager.switchImg
        love.graphics.push()
        love.graphics.translate(a.switch.x + 2, a.switch.y + 2)
        love.graphics.scale(0.25, 0.25)
        love.graphics.draw(switchImg)
        love.graphics.pop()
    end

    if a.finalText then
        love.graphics.setFont(a.cleanFont)
        love.graphics.setColor(0.1, 0.1, 0.1, a.finalTime)
        love.graphics.print("Some things are inevitable", 150, 550)
    end
    if a.finalText2 then
        love.graphics.setFont(a.cleanFont)
        love.graphics.setColor(0.1, 0.1, 0.1, a.finalTime2)
        love.graphics.print("...but not everything", 200, 600)
    end

    if a.ended then
        love.graphics.push()
        love.graphics.setFont(a.font)
        love.graphics.setColor(0, 0, 0, 1)
        if a.flip then
            love.graphics.print("Fragments", 1500, 240, 0, 1, -1)
        else
            love.graphics.print("Fragments", 1500, 50)
        end
        love.graphics.pop()

        love.graphics.setFont(a.cleanFont)
        for i=1, #a.text do
            love.graphics.setColor(0.1, 0.1, 0.1, a.text[i].timePassed * 2)
            love.graphics.print(a.text[i].text, a.text[i].x, a.text[i].y)
        end
    end



    a.door.draw()
    a.switch.draw()
    a.window.draw()
    a.tree.draw()
    a.note.draw()
    a.hRack.draw()
    a.sRack.draw()
    love.graphics.pop()

    if a.dark then
        love.graphics.setColor(0, 0, 0, 1 - (a.darkTime / 4))
        love.graphics.rectangle("fill", 0, 0, 2000, 1000)
    end
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