local a = {}

local function load()
    a.events = {}
    a.started = false
    a.timepassed = 0
    a.starttime = 0
end
a.load = load

local function update()
    if a.started then
        a.timepassed = love.timer.getTime() - a.starttime

        for i = 1, #a.events do
            local event = a.events[i]
            if not event.fired then
                if a.timepassed >= event.time then
                    event.fired = true
                    event.func()
                end
            end
        end
    end
end
a.update = update

local function draw()
    -- love.graphics.print(a.timepassed .. "   " .. test, 10, 200)
end
a.draw = draw

local function addEvent(eventFunc, time)
    local event = {func=eventFunc, time=time, fired=false}
    table.insert(a.events, event)
end
a.addEvent = addEvent

local function start()
    a.starttime = love.timer.getTime()
    a.started = true
end
a.start = start


return a