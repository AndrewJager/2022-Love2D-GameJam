local a = {}

a.load = function(utils)
    a.scenes = {}
    a.selectedScene = nil
    a.utils = utils
end

a.update = function(dt)
    a.selectedScene.scene.update()
end

a.draw = function()
    a.selectedScene.scene.draw()
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

return a