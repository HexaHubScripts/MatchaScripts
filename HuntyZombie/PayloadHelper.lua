_G.WheelsEnabled = true
_G.RideBusEnabled = true

--[[
EDITING BELOW THIS LINE CAN CAUSE ISSUES! DON'T ASK FOR HELP IF YOU EDITED BELOW
EDITING BELOW THIS LINE CAN CAUSE ISSUES! DON'T ASK FOR HELP IF YOU EDITED BELOW
EDITING BELOW THIS LINE CAN CAUSE ISSUES! DON'T ASK FOR HELP IF YOU EDITED BELOW
]]--

local lp = game.Players.LocalPlayer
local hrp = lp.Character.HumanoidRootPart

local function get_offsets()
    local t = {}
    local ok, res = pcall(function()
        return game:HttpGet("https://offsets.ntgetwritewatch.workers.dev/offsets.json")
    end)
    if not ok or not res then return t end
    for k, v in res:gmatch('"([^"]-)"%s*:%s*"([^"]-)"') do
        t[k] = v
    end
    return t
end

local offset = get_offsets()["ProximityPromptHoldDuraction"]

local function setduration(address)
    memory_write("float", address + offset, 0)
end

local function ridebus()
    while _G.RideBusEnabled do
        hrp.Position = game.Workspace.City.Rooms.Spawn.BASE.Base.Position + Vector3.new(0, 3, 0)
        task.wait(0.25)
    end
end

task.spawn(ridebus)

while _G.WheelsEnabled do
    local terrain = game.Workspace:FindFirstChild("Terrain")
    local wheel = terrain and terrain:FindFirstChild("Wheel")
    local wheelRoot = wheel and wheel:FindFirstChild("Root")
    if wheelRoot then
        _G.RideBusEnabled = false
        task.wait()
        hrp.Position = wheelRoot.Position
        
        local prompt = wheelRoot:FindFirstChildOfClass("ProximityPrompt")
        if prompt and prompt.Address then
            setduration(prompt.Address)
        end
        task.wait(2)
        _G.RideBusEnabled = true
        task.spawn(ridebus)
    end
    task.wait(0.1)
end
