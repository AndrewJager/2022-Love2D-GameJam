local a = {}

a.load = function(utils)
    a.name = "Basement-Before"
    a.background = love.graphics.newImage("img/basement-before.png")
    a.utils = utils

    local function exit()
        utils.manager.setScene("Living-Before")
    end
    a.stairs = utils.clickableArea.buildArea()
    a.stairs.load(85, 155, 350, 335, exit, "Exit Basement")

    local function ladder()
        if utils.manager.ladder.loc == "Basement-Before" then
            utils.manager.setCurItem(utils.manager.ladder) 
            a.ladder.hovertext = "Storage - Ladder"
        elseif (utils.manager.curItem.name == "Ladder") and utils.manager.itemSelected then
            utils.manager.ladder.loc = "Basement-Before"
            utils.manager.dropCurItem()
            a.ladder.hovertext = "Ladder" 
        end
    end
    a.ladder = utils.clickableArea.buildArea()
    a.ladder.load(575, 215, 130, 270, ladder, "Ladder")

    local function hammer()
        if utils.manager.hammer.loc == "Basement-Before" then
            utils.manager.setCurItem(utils.manager.hammer) 
            a.hammer.hovertext = "Storage - Sledgehammer"
        elseif (utils.manager.curItem.name == "Sledgehammer") and utils.manager.itemSelected then
            utils.manager.hammer.loc = "Basement-Before"
            utils.manager.dropCurItem()
            a.hammer.hovertext = "Sledgehammer"
        end
    end
    a.hammer = utils.clickableArea.buildArea()
    a.hammer.load(720, 290, 77, 205, hammer, "Sledgehammer")

    local function shovel()
        if utils.manager.shovel.loc == "Basement-Before" then
            utils.manager.setCurItem(utils.manager.shovel)
            a.shovel.hovertext = "Storage - Shovel"
        elseif (utils.manager.curItem.name == "Shovel") and utils.manager.itemSelected then
            utils.manager.shovel.loc = "Basement-Before"
            utils.manager.dropCurItem()
            a.shovel.hovertext = "Shovel"
        end
    end
    a.shovel = utils.clickableArea.buildArea()
    a.shovel.load(810, 215, 65, 275, shovel, "Shovel")
end

a.update = function()
   
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.push()
    love.graphics.scale(0.85, 0.85)
    love.graphics.draw(a.background, 98, 30)
    love.graphics.pop()

    local ladder = a.utils.manager.ladder
    if (ladder.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.ladder.x + 2, a.ladder.y + 2)
        love.graphics.scale(0.5, 0.5)
        love.graphics.draw(ladder.img)
        love.graphics.pop()
    end

    local hammer = a.utils.manager.hammer
    if (hammer.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.hammer.x + 2, a.hammer.y + 2)
        love.graphics.scale(0.4, 0.4)
        love.graphics.draw(hammer.img)
        love.graphics.pop()
    end

    local shovel = a.utils.manager.shovel
    if (shovel.loc == "Basement-Before") then
        love.graphics.push()
        love.graphics.translate(a.shovel.x + 2, a.shovel.y + 2)
        love.graphics.scale(0.4, 0.4)
        love.graphics.draw(shovel.img)
        love.graphics.pop()
    end

    a.stairs.draw()
    a.ladder.draw()
    a.hammer.draw()
    a.shovel.draw()
end

a.mousemoved = function(x, y)
    a.stairs.mousemoved(x, y)
    a.ladder.mousemoved(x, y)
    a.hammer.mousemoved(x, y)
    a.shovel.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.stairs.mousepressed(x, y)
    a.ladder.mousepressed(x, y)
    a.hammer.mousepressed(x, y)
    a.shovel.mousepressed(x, y)
end

return a