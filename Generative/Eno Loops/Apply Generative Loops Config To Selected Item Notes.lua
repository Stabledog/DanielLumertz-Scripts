--@noindex
------ Load Functions
-- Function to dofile all files in a path
function dofile_all(path)
    local i = 0
    while true do 
        local file = reaper.EnumerateFiles( path, i )
        i = i + 1
        if not file  then break end 
        dofile(path..'/'..file)
    end
end

-- get script path
ScriptPath = debug.getinfo(1,'S').source:match[[^@?(.*[\/])[^\/]-$]]
-- dofile all files inside functions folder
dofile_all(ScriptPath..'/'..'Functions')


local proj = 0
local items_pattern = '$$$LOOP_CONFIG$$$'
local base_setting = [[
    $Time Randomize: 0 - 0
    $Time Random Quantize: 0
    $Pitch Randomize: 0 - 0
    $Pitch Random Quantize: 0
    $Playrate Randomize: 0
    $Playrate Random Quantize: 0
    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$]]
ExtStatePatterns()

ScriptName = 'Generative Loops Item Options'
Version = '0.0.1'

--- Defaults
function SetDefaults()
    RandomizeTakes = false
    TakeChance = 1
    TimeRandomMin = 0
    TimeRandomMax = 0
    TimeQuantize = 0
    PitchRandomMin = 0
    PitchRandomMax = 0
    PitchQuantize = 0
    PlayRateRandomMin = 1 -- cannot be 0!
    PlayRateRandomMax = 1 -- cannot be 0!
    PlayRateQuantize = 0
end

SetDefaults()
GuiInit(ScriptName)
main_loop()