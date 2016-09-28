local application = require "mjolnir.application"
local hotkey      = require "mjolnir.hotkey"
local window      = require "mjolnir.window"
local fnutils     = require "mjolnir.fnutils"

local function launcher(app)
  return function()
    application.launchorfocus(app)
  end
end

local function showOrHide(bundleid)
  return function()
    local app = application.applicationsforbundleid(bundleid)[1]
    if (app:ishidden()) then
      app:activate()
    else
      app:hide()
    end
  end
end

local hyper = {"cmd", "ctrl", "alt", "shift"}

hotkey.bind(hyper, "A", launcher("Atom"))
hotkey.bind(hyper, "B", launcher("Sublime Text"))
hotkey.bind(hyper, "C", launcher("Google Chrome"))
hotkey.bind(hyper, "S", launcher("Safari"))
hotkey.bind(hyper, "T", launcher("iTerm"))
hotkey.bind(hyper, "E", launcher("Eclipse"))
hotkey.bind(hyper, "I", launcher("IntelliJ IDEA CE"))
hotkey.bind(hyper, "F", launcher("Finder"))
hotkey.bind(hyper, "G", launcher("SourceTree"))
hotkey.bind(hyper, "H", launcher("GitUp"))
hotkey.bind(hyper, "M", launcher("Mail Pilot"))
hotkey.bind(hyper, "N", launcher("Evernote"))
hotkey.bind(hyper, "P", launcher("Preview"))
-- hotkey.bind(hyper, "U", showOrHide("com.spotify.client"))
hotkey.bind(hyper, "U", launcher("Spotify"))
hotkey.bind(hyper, "V", launcher("Emacs"))
-- hotkey.bind(hyper, "W", launcher("Wunderlist"))
hotkey.bind(hyper, "W", launcher("WebStorm"))
hotkey.bind(hyper, "X", launcher("Xcode"))
hotkey.bind(hyper, "Z", launcher("Slack"))
