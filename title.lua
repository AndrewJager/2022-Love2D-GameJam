local a = {}

a.load = function(utils)
    a.name = "Title"
    a.manager = utils.manager
    a.back = a.manager.backBefore
    a.font = love.graphics.newFont("font/Dokdo/Dokdo-Regular.ttf", 200)

    a.timePassed = 0
    a.startTime = 0


    a.script = utils.sceneScripter.buildScene()
    a.script.load()
    a.script.addEvent(function()
            a.startTime = love.timer.getTime()
        end, 0)

    a.script.addEvent(function()
            a.manager.setScene("Outside-After")
        end, 6)
end

a.update = function(dt)
    if not a.started then 
        a.script.start()
        a.started = true
    end
    a.script.update()

    if a.timePassed < 1 then
        a.timePassed = love.timer.getTime() - a.startTime
    end
end

a.draw = function()
    love.graphics.push()
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()
    love.graphics.push()
    love.graphics.setColor(0, 0, 0, a.timePassed)
    love.graphics.setFont(a.font)
    love.graphics.print("Fragments", 80, 50)
    love.graphics.pop()
end

a.mousemoved = function(x, y)

end

a.mousepressed = function(x, y)

end

return a