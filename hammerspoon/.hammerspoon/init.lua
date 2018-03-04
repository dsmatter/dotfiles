hs.allowAppleScript(true)

---
--- Hyper Key Setup ---
---

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  --if not k.triggered then
  --  hs.eventtap.keyStroke({}, 'ESCAPE')
  --end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

---
--- Helper Functions
---

local function launcher(app)
  return function()
    hs.application.launchOrFocus(app)
  end
end

local function showOrHide(bundleid)
  return function()
    local app = hs.application.applicationsForBundleID(bundleid)[1]
    if (app:ishidden()) then
      app:activate()
    else
      app:hide()
    end
  end
end

---
--- Key Bindings
---

k:bind('', "A", launcher("Things3"))
k:bind('', "B", launcher("Sublime Text"))
k:bind('', 'C', launcher("Google Chrome"))
k:bind('', "C", launcher("Google Chrome"))
k:bind('', "F", launcher("Finder"))
k:bind('', "G", launcher("SourceTree"))
k:bind('', "H", launcher("GitUp"))
k:bind('', "I", launcher("IntelliJ IDEA CE"))
k:bind('', "K", launcher("Karabiner-Elements"))
k:bind('', "M", launcher("Mail"))
k:bind('', "N", launcher("Evernote"))
k:bind('', "P", launcher("Preview"))
k:bind('', "R", launcher("Simulator"))
k:bind('', "S", launcher("Safari"))
k:bind('', "T", launcher("iTerm"))
k:bind('', "U", launcher("Spotify"))
k:bind('', "V", launcher("Visual Studio Code"))
k:bind('', "W", launcher("WebStorm"))
k:bind('', "X", launcher("Xcode"))
k:bind('', "Z", launcher("Slack"))