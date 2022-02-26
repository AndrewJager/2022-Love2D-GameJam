local a = {}

a.load = function(utils)
    a.name = "Test Scene"
    a.test = "0"
    a.introScript = utils.sceneScripter.buildScene()

    a.introScript.load()
    local function aa()
        a.test = "1"
    end
    local function b()
        a.test = "2"
    end
    local function c()
        a.test = "3"
    end
    local function d()
        a.test = "4"
    end

    a.introScript.addEvent(aa, 1)
    a.introScript.addEvent(b, 2)
    a.introScript.addEvent(c, 4)
    a.introScript.start()

    a.clickA = utils.clickableArea.buildArea()
    a.clickB = utils.clickableArea.buildArea()

    a.clickA.load(200, 50, 80, 80, d, "")
    a.clickB.load(200, 150, 80, 80, d, "Testing hover text")
end

a.update = function()
    a.introScript.update()
end

a.draw = function()
    love.graphics.setColor(1, 1, 1) 
    love.graphics.print(a.test, 10, 10)

    a.introScript.draw()
    a.clickA.draw()
    a.clickB.draw()
end

a.mousemoved = function(x, y)
    a.clickA.mousemoved(x, y)
    a.clickB.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.clickA.mousepressed(x, y)
    a.clickB.mousepressed(x, y)
end

return a