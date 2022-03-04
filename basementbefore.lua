local a = {}

a.load = function(utils)
    a.name = "Basement-Before"
    a.back = utils.manager.backBefore
    a.background = love.graphics.newImage("img/basement-before.png")
    a.colState = 1
    a.colImgs = {}
    table.insert(a.colImgs, love.graphics.newImage("img/items/col-A.png"))
    table.insert(a.colImgs, love.graphics.newImage("img/items/col-B.png"))
    table.insert(a.colImgs, love.graphics.newImage("img/items/col-C.png"))
    table.insert(a.colImgs, love.graphics.newImage("img/items/col-D.png"))
    table.insert(a.colImgs, love.graphics.newImage("img/items/col-E.png"))
    a.colDlgs = {
        "No more of this confusion",
        "No longer will I be governed by fate!",
        "This ends here!",
        "This ends now!"
    }
    a.manager = utils.manager

    local function exit()
        utils.manager.setScene("Living-Before")
    end
    a.stairs = utils.clickableArea.buildArea()
    a.stairs.load(85, 155, 350, 335, exit, "Exit Basement")

    local function ladder()
        a.manager.areaHandler(a.manager.ladder, "Basement-Before", a.ladder, "Storage - Ladder", "Ladder")
    end
    a.ladder = utils.clickableArea.buildArea()
    a.ladder.load(575, 215, 130, 270, ladder, "Ladder")

    local function hammer()
        a.manager.areaHandler(a.manager.hammer, "Basement-Before", a.hammer, "Storage - Hammer", "Hammer")
    end
    a.hammer = utils.clickableArea.buildArea()
    a.hammer.load(720, 290, 77, 205, hammer, "Sledgehammer")

    local function shovel()
        a.manager.areaHandler(a.manager.shovel, "Basement-Before", a.shovel, "Storage - Shovel", "Shovel")
    end
    a.shovel = utils.clickableArea.buildArea()
    a.shovel.load(810, 215, 65, 275, shovel, "Shovel")

    local colDelay = a.manager.textDelay
    a.colScript = utils.sceneScripter.buildScene()
    a.colScript.load()
    a.colScript.addEvent(function()
            a.manager.addDialog("This always seem so sturdy to me, like it could never break")
        end, 0)
    a.colScript.addEvent(function()
            a.manager.addDialog("I guess the earthquake was too much for it")
        end, 1 * colDelay)

    a.colDescDone = false
    local function column()
        if (a.manager.curItem ~= nil) and (a.manager.curItem.name == "Sledgehammer") 
            and a.manager.itemSelected then
            if a.manager.dreamed then
                a.manager.addDialog(a.colDlgs[a.colState])
                if a.colState <= 4 then
                    a.colState = a.colState + 1
                end
                if a.colState == 5 then
                    a.column.enabled = false
                    a.stairs.enabled = false
                    a.ladder.enabled = false
                    a.hammer.enabled = false
                    a.shovel.enabled = false
                    a.endScript.start()
                end
            else
                a.manager.feedback = "That doesn't seem very wise"
            end
        else
            if not a.colDescDone then
                a.colScript.start()
                a.colDescDone = true
            end
        end

    end
    a.column = utils.clickableArea.buildArea()
    a.column.load(480, 30, 40, 460, column, "Support Column", true)

    local delay = a.manager.textDelay
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("This was our basement. My parents kept their tools here")
        end, 0.5 * delay)

    a.afterScript = utils.sceneScripter.buildScene()
    a.afterScript.load()
    a.afterScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("Thank you for doing this with me")
        end, 0.5 * delay)

    a.shake = false
    a.fall = false
    a.fallAmt = 0
    a.dark = false
    a.darkAmt = 0
    a.darkStart = 0
    a.endScript = utils.sceneScripter.buildScene()
    a.endScript.load()
    a.endScript.addEvent(function()
        a.shake = true
    end, 1 * delay)
    a.endScript.addEvent(function()
        a.fall = true
        a.manager.drawUI = false
    end, 3 * delay)
    a.endScript.addEvent(function()
        a.dark = true
        a.darkStart = love.timer.getTime()
    end, 5.5 * delay)
    a.endScript.addEvent(function()
        a.manager.setScene("Outside-After")
        a.manager.broken = true
    end, 7 * delay)
end

a.update = function(dt)
    a.colScript.update()

    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update()

    if a.manager.dreamed and (not a.afterStarted) then 
        a.afterScript.start()
        a.afterStarted = true
    end
    a.afterScript.update()

    a.endScript.update()
    if a.fall then
        a.fallAmt = a.fallAmt + (dt * 500)
    end

    if a.dark and (a.darkStart ~= 0) and (a.darkAmt < 1) then
        a.darkAmt = love.timer.getTime() - a.darkStart
    end
end

a.draw = function()
    if a.shake then
        love.graphics.translate(math.random(-3, 3), math.random(-1, 1))
    end
    love.graphics.push()
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

    love.graphics.push()
    if a.fall then
        love.graphics.translate(0, a.fallAmt)
    end

    love.graphics.push()
    love.graphics.scale(0.85, 0.85)
    love.graphics.draw(a.background, 98, 30)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.translate(480, 30)
    love.graphics.scale(0.41, 0.41)
    love.graphics.draw(a.colImgs[a.colState])
    love.graphics.pop()

    local ladder = a.manager.ladder
    if (ladder.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.ladder.x + 2, a.ladder.y + 2)
        love.graphics.scale(0.5, 0.5)
        love.graphics.draw(ladder.img)
        love.graphics.pop()
    end

    local hammer = a.manager.hammer
    if (hammer.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.hammer.x + 2, a.hammer.y + 2)
        love.graphics.scale(0.4, 0.4)
        love.graphics.draw(hammer.img)
        love.graphics.pop()
    end

    local shovel = a.manager.shovel
    if (shovel.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.shovel.x + 2, a.shovel.y + 2)
        love.graphics.scale(0.4, 0.4)
        love.graphics.draw(shovel.img)
        love.graphics.pop()
    end
    love.graphics.pop()

    if a.dark then
        love.graphics.setColor(0, 0, 0, a.darkAmt)
        love.graphics.rectangle("fill", 0, 0, 2000, 1000)
    end

    a.stairs.draw()
    a.ladder.draw()
    a.hammer.draw()
    a.shovel.draw()
    a.column.draw()
end

a.mousemoved = function(x, y)
    a.stairs.mousemoved(x, y)
    a.ladder.mousemoved(x, y)
    a.hammer.mousemoved(x, y)
    a.shovel.mousemoved(x, y)
    a.column.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.stairs.mousepressed(x, y)
    a.ladder.mousepressed(x, y)
    a.hammer.mousepressed(x, y)
    a.shovel.mousepressed(x, y)
    a.column.mousepressed(x, y)
end

return a