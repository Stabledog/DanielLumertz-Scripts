-- @version 0.1.2b
-- @author Daniel Lumertz
-- @provides
--    [nomain] DL Functions/*.lua
--    [nomain] Clouds Functions/*.lua
--    [nomain] Image/Cloud.png
--    [nomain] Info/*.txt
--    [nomain] User Presets/*.json
--    [nomain] User Settings/*.json
--    [effect] FX/daniellumertz_Clouds.jsfx
-- @changelog
--    + Initial tests

-- Debug
--local VSDEBUG = dofile("c:/Users/DSL/.vscode/extensions/antoinebalaine.reascript-docs-0.1.12/debugger/LoadDebug.lua")

-- Constants:
SCRIPT_NAME = 'Clouds'
SCRIPT_V  = '0.1.2'
EXT_NAME = 'daniellumertz_Clouds'     -- keys: settings (for clouds), is_item (for generated items)
FX_NAME = 'daniellumertz_Clouds'
Proj = 0
CloudColor = 25987079
CloudImage = debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "Image/Cloud.png"
FXENVELOPES = {
    density = 0,
    dust = 1,
    randomization = {
        vol = 2,
        pan = 3,
        pitch = 4,
        stretch = 5,
        reverse = 6
    },
    grains = {
        size = 7,
        randomize_size = 8,
        position = 9,
        randomize_position = 10
    }
}
CONSTRAINS = {
    exp = 0.01,
    grain_low = 1/10, --in ms
    grain_rand_low = -99.99, -- in %
    stretch_low = 0.01,
    db_minmax = 150,
    grain_density_ratio = {
        min = 25,
        max = 200
    }
}
UPDATE_FREQ = {time = 0.1, items = 100}
PRESETS = { -- path and suggested names
    path = debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "User Presets/",
    suggestions = {"My Preset", "Beautiful Preset", "iTexture", "Clouds n' Clovis", "Justin Time", "Schwahwah", "A Damn Fine Cup Of Coffee"},
    i = 0
}
SETTINGS = {
    path = debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "User Settings/settings.json",
}
URL = {
    buy = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    thread = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    manual = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    video = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
}

-- Initialize ImGUI
package.path = package.path..';'..reaper.ImGui_GetBuiltinPath() .. '/?.lua'
ImGui = require 'imgui' '0.9.2' 
--demo = require 'ReaImGui_Demo' --DEBUG

-- Initialize Functions
--package.path = package.path..';'..debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "/DL Functions/?.lua;" -- GET DIRECTORY FOR REQUIRE
package.path = package.path..';'..debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "?.lua;" -- GET DIRECTORY FOR REQUIRE
package.path = package.path..';'..debug.getinfo(1, "S").source:match [[^@?(.*[\/])[^\/]-$]] .. "/Clouds Functions/?.lua;" -- GET DIRECTORY FOR REQUIRE
require('DL Functions.General Debug')
require('DL Functions.General Number')
require('DL Functions.General Table')
require('DL Functions.General String')
require('DL Functions.REAPER Checker')
require('DL Functions.Serialize')
require('DL Functions.REAPER Items')
require('DL Functions.REAPER Enumerate')
require('DL Functions.REAPER Chunks')
require('DL Functions.General Files')
require('DL Functions.ImGui')
require('DL Functions.json')
require('DL Functions.URL')

require('Clouds Items')
require('Clouds Convert GUIDS')
require('Clouds Apply')
require('Clouds Presets')
require('Clouds Themes')
require('Clouds Settings')
require('Clouds Tracks')
require('Clouds GUI')

-- Check versions
DL.check.ReaImGUI('0.9.2')

-- Load User Settings
Settings = Clouds.Settings.Load(SETTINGS.path)

-- Start Main
reaper.defer(Clouds.GUI.Main)


