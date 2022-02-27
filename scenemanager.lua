local a = {}

a.load = function(utils)
    a.scenes = {}
    a.selectedScene = nil
    a.utils = utils

    a.d1 = "Hello"
    a.d2 = "Two"
    a.d3 = "Three"
    a.d4 = "Four"
    a.d5 = "Five"
    a.d6 = "Six"
    a.feedback = "Cats are evil"
end

a.update = function(dt)
    a.selectedScene.scene.update()
end

a.draw = function()
    a.selectedScene.scene.draw()

    love.graphics.setLineWidth(1)
    love.graphics.setLineJoin("bevel")
    love.graphics.setColor(0, 0, 0.8, 1)
    love.graphics.rectangle("line", 110, 550, 500, 130)
    love.graphics.print(a.d1, 115, 555)
    love.graphics.print(a.d2, 115, 575)
    love.graphics.print(a.d3, 115, 595)
    love.graphics.print(a.d4, 115, 615)
    love.graphics.print(a.d5, 115, 635)
    love.graphics.print(a.d6, 115, 655)

    love.graphics.rectangle("line", 630, 600, 80, 80)

    love.graphics.setColor(0.8, 0, 0, 1)
    love.graphics.rectangle("line", 630, 550, 350, 20)
    love.graphics.print(a.feedback, 635, 553)
end

a.mousemoved = function(x, y)
    a.selectedScene.scene.mousemoved(x, y)
end

a.mousepressed = function(x, y)
    a.selectedScene.scene.mousepressed(x, y)
end

a.addScene = function(scene)
    scene.load(a.utils)
    table.insert(a.scenes, {name=scene.name, scene=scene})
end

a.setScene = function(sceneName)
    for i = 1, #a.scenes do
        if a.scenes[i].name == sceneName then
            a.selectedScene = a.scenes[i]
            break
        end
    end
end

a.addDialog = function(text)
    a.d1 = a.d2
    a.d2 = a.d3
    a.d3 = a.d4
    a.d4 = a.d5
    a.d5 = a.d6
    a.d6 = text
end

return a