local a = {}

a.load = function(utils)
    a.name = "Living-After"
    a.background = love.graphics.newImage("img/living-after.png")
    a.debrisImg = love.graphics.newImage("img/items/debris.png")
    a.manager = utils.manager
    a.cleared = false

    local function enterRoom()
        utils.manager.setScene("Bedroom-After")
    end
    a.bedroomDoor = utils.clickableArea.buildArea()
    a.bedroomDoor.load(105, 90, 130, 340, enterRoom, "Bedroom")

    local function basement()
        a.manager.feedback = "Too much rubble. No way in."
    end
    a.basement = utils.clickableArea.buildArea()
    a.basement.load(240, 385, 140, 85, basement, "Basement Stairs")

    local function getPillow()
       if utils.manager.setCurItem(utils.manager.pillow) then
           a.pillow.enabled = false
       end
    end
    a.pillow = utils.clickableArea.buildArea()
    a.pillow.load(500, 380, 68, 40, getPillow, "Pillow")
    a.pillow.enabled = false

    local function rubble()
        if (a.manager.curItem ~= nil) and (a.manager.curItem.name == "Shovel") 
            and a.manager.itemSelected then
            a.cleared = true
            a.rubble.enabled = false
            a.pillow.enabled = true
            a.picture.enabled = true
        end
    end
    a.rubble = utils.clickableArea.buildArea()
    a.rubble.load(450, 320, 300, 150, rubble, "Debris")

    local function picture()
        if a.manager.setCurItem(a.manager.picture) then
            a.picture.enabled = false
        end
    end
    a.picture = utils.clickableArea.buildArea()
    a.picture.load(640, 385, 80, 70, picture, "Missing Picture")
    a.picture.enabled = false

    local function wall()
        if (a.manager.curItem ~= nil) and (a.manager.curItem.name == "Missing Picture") 
            and a.manager.itemSelected then
            a.manager.picturePlaced = true
            a.wall.enabled = false
            a.manager.dropCurItem()
        end
    end
    a.wall = utils.clickableArea.buildArea()
    a.wall.load(280, 160, 250, 130, wall, "Wall")

    local delay = a.manager.textDelay
    a.introScript = utils.sceneScripter.buildScene()
    a.introScript.load()
    a.introScript.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("Such a mess")
        end, 0.5 * delay)
    a.introScript.addEvent(function()
        a.manager.addDialog("We should dig through here. Maybe there's something worth finding?")
    end, 1.5 * delay)
end

a.update = function()
    if not a.started then 
        a.introScript.start()
        a.started = true
    end
    a.introScript.update()
end

a.draw = function()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8, 1)
    love.graphics.push()
    love.graphics.scale(0.85, 0.85)
    love.graphics.draw(a.background, 98, 0)
    love.graphics.pop()

    local pillow = a.manager.pillow
    if (pillow.loc == "Living-After" and a.pillow.enabled) then
        love.graphics.draw(pillow.img, a.pillow.x + 2, a.pillow.y + 2)
    end

    local picture = a.manager.picture
    if (picture.loc == "Living-After" and a.picture.enabled) then
        love.graphics.push()
        love.graphics.translate(a.picture.x + 65, a.picture.y)
        love.graphics.scale(0.3, 0.3)
        love.graphics.rotate(math.rad(78))
        love.graphics.draw(picture.img)
        love.graphics.pop()
    end

    if (a.rubble.enabled) then
        love.graphics.push()
        love.graphics.translate(a.rubble.x, a.rubble.y)
        love.graphics.scale(0.7, 0.7)
        love.graphics.draw(a.debrisImg)
        love.graphics.pop()
    end

    if a.manager.picturePlaced then
        love.graphics.push()
        love.graphics.translate(350, 160)
        love.graphics.scale(0.3, 0.3)
        love.graphics.draw(picture.img)
        love.graphics.pop() 
    end

    a.pillow.draw()
    a.bedroomDoor.draw()
    a.basement.draw()
    a.rubble.draw()
    a.picture.draw()
    a.wall.draw()
end

a.mousemoved = function(x, y)
    a.pillow.mousemoved(x, y)
    a.bedroomDoor.mousemoved(x, y)
    a.basement.mousemoved(x, y)
    a.rubble.mousemoved(x, y)
    a.picture.mousemoved(x, y)
    a.wall.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.pillow.mousepressed(x, y)
    a.bedroomDoor.mousepressed(x, y)
    a.basement.mousepressed(x, y)
    a.rubble.mousepressed(x, y)
    a.picture.mousepressed(x, y)
    a.wall.mousepressed(x, y)
end

return a