local builder = {}
local function buildArea()
    local a = {}

    local function load(x, y, width, height, func, hovertext)
        a.x = x
        a.y = y
        a.width = width
        a.height = height
        a.func = func
        a.hover = false
        a.hovertext = hovertext
    end
    a.load = load
    
    local function draw()
        if a.hover then
            love.graphics.setColor(1, 1, 1)
            love.graphics.setLineWidth(3)
    
            local padding = 5
            love.graphics.print(a.hovertext, a.x + a.width + padding, a.y + a.height + padding)
        else
            love.graphics.setColor(0, 0, 0.7) 
            love.graphics.setLineWidth(1)
        end
        love.graphics.rectangle("line", a.x, a.y, a.width, a.height)
    end
    a.draw = draw
    
    local function mousemoved(x, y)
        if ((x > a.x) and (x < (a.x + a.width)))
            and ((y > a.y) and (y < (a.y + a.height)))
        then
            a.hover = true
        else
            a.hover = false
        end
    end
    a.mousemoved = mousemoved
    
    local function mousepressed(x, y)
        if ((x > a.x) and (x < (a.x + a.width)))
            and ((y > a.y) and (y < (a.y + a.height)))
        then
            a.func() --Execute function
        end
    end
    a.mousepressed = mousepressed
    
    return a
end
builder.buildArea = buildArea

return builder