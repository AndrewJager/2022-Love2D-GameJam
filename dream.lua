local a = {}

a.load = function(utils)
    local function addText(text, x, y)
        local newText = {}
        newText.text = text
        newText.x = x
        newText.y = y
        newText.timePassed = 0
        newText.fadeTime = 0.5
        table.insert(a.text, newText)
    end
    a.name = "Dream"
    a.manager = utils.manager
    a.text = {}
    a.font = love.graphics.newFont("font/Architects_Daughter/ArchitectsDaughter-Regular.ttf", 20)
    a.back = a.manager.backAfter
    a.house = love.graphics.newImage("img/outside-before.png")
    a.house2 = love.graphics.newImage("img/outside-after.png")

    a.started = false
    a.flip = false

    local delay = a.manager.textDelay
    local x = 60
    local y = 400
    a.script = utils.sceneScripter.buildScene()
    a.script.load()
    a.script.addEvent(function()
            addText("I'd hoped this would bring me peace", x, y * 1)
        end, delay * 1)
    a.script.addEvent(function()
            addText("But I can't make sense of this", x + 600, y)
        end, delay * 2)
    a.script.addEvent(function()
            addText("Everything has turned upside down", x, y + 100)
            a.flip = true
        end, delay * 3)
    a.script.addEvent(function()
            addText("Nothing feels right", x + 600, y + 100)
        end, delay * 4)
    a.script.addEvent(function()
            addText("Everything seems broken", x + 320, y + 200)
            a.flip = false
            a.house = a.house2
        end, delay * 6)

    a.script.addEvent(function()
        a.manager.dreamed = true
        a.manager.setScene("Bedroom-After")
    end, delay * 8)
             

    a.script.start()
end

a.update = function(dt)
    if not a.started then 
        a.script.start()
        a.started = true
    end
    a.script.update()
    for i=1, #a.text do
        if a.text[i].timePassed <= a.text[i].fadeTime then
            a.text[i].timePassed = a.text[i].timePassed + dt
        end
    end
end

a.draw = function()
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.push()
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(a.back, -10, -10)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(300, 0)
    love.graphics.scale(0.55, 0.55)
    if a.flip then
        love.graphics.translate(0, 650)
        love.graphics.draw(a.house, 0, 0, 0, 1, -1)
    else
        love.graphics.draw(a.house)
    end
    
    love.graphics.pop()

    love.graphics.push("all")
    love.graphics.setFont(a.font)
    for i=1, #a.text do
        love.graphics.setColor(0.1, 0.1, 0.1, a.text[i].timePassed * 2)
        love.graphics.print(a.text[i].text, a.text[i].x, a.text[i].y)
    end
    love.graphics.pop()
end

a.mousemoved = function(x, y)

end

a.mousepressed = function(x, y)

end

return a