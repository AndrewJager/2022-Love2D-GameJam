local builder = {}
builder.buildArea = function()
    local a = {}

    local function load(x, y, width, height, func, hovertext, bottom)
        a.x = x
        a.y = y
        a.width = width
        a.height = height
        a.func = func
        a.hover = false
        a.hovertext = hovertext
        a.enabled = true
        a.font = love.graphics.newFont("font/Source_Code_Pro/SourceCodePro-Medium.ttf", 15)
        if bottom then
            a.bottom = true
        end
    end
    a.load = load
    
    local function draw()
        if a.enabled then
            if a.hover then
                love.graphics.setColor(1, 1, 1)
                love.graphics.setLineWidth(3)
                love.graphics.setFont(a.font)
                love.graphics.rectangle("line", a.x, a.y, a.width, a.height)
                if not a.bottom then
                    love.graphics.rectangle("fill", a.x - 2, a.y - 22, a.font:getWidth(a.hovertext) + 4, 20)
                    love.graphics.setColor(0.1, 0.1, 0.1)
                    love.graphics.print(a.hovertext, a.x, a.y - 20)
                else
                    love.graphics.rectangle("fill", a.x - 2, a.y + a.height, a.font:getWidth(a.hovertext) + 4, 20)
                    love.graphics.setColor(0.1, 0.1, 0.1)
                    love.graphics.print(a.hovertext, a.x, a.y + a.height)
                end
            else
                love.graphics.setColor(0, 0, 0.7) 
                love.graphics.setLineWidth(1)
            end
        end
    end
    a.draw = draw
    
    local function mousemoved(x, y)
        if a.enabled then 
            if ((x > a.x) and (x < (a.x + a.width)))
                and ((y > a.y) and (y < (a.y + a.height)))
            then
                a.hover = true
            else
                a.hover = false
            end
        end
    end
    a.mousemoved = mousemoved
    
    local function mousepressed(x, y)
        if a.enabled then
            if ((x > a.x) and (x < (a.x + a.width)))
                and ((y > a.y) and (y < (a.y + a.height)))
            then
                a.func() --Execute function
            end
        end
    end
    a.mousepressed = mousepressed
    
    return a
end

return builder