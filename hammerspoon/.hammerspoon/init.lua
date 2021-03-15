hs.hotkey.bind({"cmd", "shift", "alt", "ctrl"}, "1", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    f.x = screenFrame.x
    f.y = screenFrame.y
    f.w = screenFrame.w / 2
    f.h = screenFrame.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift", "alt", "ctrl"}, "2", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    f.x = screenFrame.x + screenFrame.w / 2
    f.y = screenFrame.y
    f.w = screenFrame.w / 2
    f.h = screenFrame.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift", "alt", "ctrl"}, "3", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    f.x = screenFrame.x
    f.y = screenFrame.y
    f.w = screenFrame.w
    f.h = screenFrame.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift", "alt", "ctrl"}, "4", function()
    local win = hs.window.focusedWindow()

    local screenIndex = 0
    local screenCount = 0
    for i, screen in pairs(hs.screen.allScreens()) do
        if screen == win:screen() then
            screenIndex = i
        end
        screenCount = screenCount + 1
    end

    local f = win:frame()
    local screen = hs.screen.allScreens()[(screenIndex % screenCount) + 1]
    local screenFrame = screen:frame()

    f.x = screenFrame.x
    f.y = screenFrame.y
    win:setFrame(f)
end)