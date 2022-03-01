local a = {}

a.load = function(utils)
    a.name = "Intro-2"
    a.manager = utils.manager
    a.back = a.manager.backBefore
    a.background = love.graphics.newImage("img/outside-before.png")
    a.background2 = love.graphics.newImage("img/outside-after.png")
    a.treeImg = love.graphics.newImage("img/tree-before.png")
    a.rackImg = love.graphics.newImage("img/items/rack.png")

    a.started = false
    a.shake = false
    a.broken = false

    local begin = 1
    local delay = 2
    a.script = utils.sceneScripter.buildScene()
    a.script.load()
    a.script.addEvent(function()
            a.manager.addDialog("This is my childhoom home, where I grew up")
        end, begin + delay * 1)
    a.script.addEvent(function()
            a.manager.addDialog("What you see here, what you do here, is only in my memories now")
        end, begin + delay * 2)
    a.script.addEvent(function()
            
        end, begin + delay * 3)
    a.script.addEvent(function()
            a.manager.addDialog("")
            a.manager.addDialog("The world shook, and everything fell apart")
        end, begin + delay * 4)
    a.script.addEvent(function()
            a.shake = true
        end, begin + delay * 5)
    a.script.addEvent(function()
            a.broken = true
        end, begin + delay * 6)
    a.script.addEvent(function()
            a.shake = false
        end, begin + delay * 7)
end

a.update = function(dt)
    if not a.started then 
        a.script.start()
        a.started = true
    end
    a.script.update()
end

a.draw = function()
    love.graphics.push()
    if a.shake then
        love.graphics.translate(math.random(-3, 3), math.random(-1, 1))
    end
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.push()
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

    if a.broken then
        love.graphics.push()
        love.graphics.scale(0.7, 0.7)
        love.graphics.draw(a.background2, 100, 30)
        love.graphics.pop()
    else
        love.graphics.push()
        love.graphics.scale(0.7, 0.7)
        love.graphics.draw(a.background, 100, 30)
        love.graphics.pop()
    end

    love.graphics.push()
    love.graphics.scale(0.6, 0.6)
    love.graphics.draw(a.treeImg, 1050, 0)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(575, 320)
    love.graphics.scale(0.6, 0.6)
    love.graphics.draw(a.rackImg)
    love.graphics.pop()
    love.graphics.pop()
end

a.mousemoved = function(x, y)

end

a.mousepressed = function(x, y)

end

return a