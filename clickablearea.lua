local a = {}

local function load(x, y, width, height, func)
    a.x = x
    a.y = y
    a.width = width
    a.height = height
    a.func = func
    a.hover = false
end
a.load = load

local function draw()
    if a.hover then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(3)
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