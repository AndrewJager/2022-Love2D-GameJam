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
    a.name = "Intro"
    a.manager = utils.manager
    a.text = {}
    a.font = love.graphics.newFont("font/Architects_Daughter/ArchitectsDaughter-Regular.ttf", 20)
    a.cleanFont = love.graphics.newFont("font/Source_Code_Pro/SourceCodePro-Medium.ttf", 20)
    a.back = a.manager.backBefore

    a.begin = false
    a.started = false

    local delay = 0.1
    local x = 200
    local y = 50
    a.script = utils.sceneScripter.buildScene()
    a.script.load()
    a.script.addEvent(function()
            addText("This probably isn't going to make much sense to you", x, y * 1)
        end, delay * 1)
    a.script.addEvent(function()
            addText("But that's okay, it doesn't really make sense to me", x, y * 2)
        end, delay * 2)
    a.script.addEvent(function()
            addText("I need you to find something for me, buried in what remains", x, y * 3)
        end, delay * 3)
    a.script.addEvent(function()
            addText("If you have doubts, don't worry. Nothing here will matter to you", x, y * 4)
        end, delay * 4)
    a.script.addEvent(function()
            addText("Just assume that you're asleep, and this is all a dream", x, y * 5)
        end, delay * 5)
    a.script.addEvent(function()
        addText("Just a dream...", x + 200, y * 7)
    end, delay * 7)

    a.script.addEvent(function()
        a.begin = true
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

    love.graphics.push("all")
    love.graphics.shear(0, 0.02)
    love.graphics.setFont(a.font)
    for i=1, #a.text do
        love.graphics.setColor(0.1, 0.1, 0.1, a.text[i].timePassed * 2)
        love.graphics.print(a.text[i].text, a.text[i].x, a.text[i].y)
    end

    if a.begin then
        love.graphics.setFont(a.cleanFont)
        love.graphics.shear(0, -0.02)
        love.graphics.setColor(0.1, 0.1, 0.1, 1)
        love.graphics.print("(click anywhere)", 425, 600)
    end
    love.graphics.pop()
end

a.mousemoved = function(x, y)

end

a.mousepressed = function(x, y)
    if a.begin then
       a.manager.setScene("Intro-2") 
    end
end

return a