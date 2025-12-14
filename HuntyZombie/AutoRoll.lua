_G.rolling = true

local wtime = 0.8
local gui = game.Players.LocalPlayer.PlayerGui
local cwlabel = gui.GUI.Spin_Weapons.Header

-- Put any Legendary+ weapons you want to auto skip in this table in ALL CAPS
local whitelisted = {
    "CHAINSAW",
    "SLEDGE HAMMER",
    "GUITAR",
    "DUAL GUN",
    "ZOMBIE CLAWS",
    "KATANA",
    "GREATSWORD",
    "SCISSORS",
    "ANCHOR",
    "HANDFAN",
    "SHOES",
    "GHOST",
    "SPINAL BLADE",
    "WIZARD"
}

local function weaponroll()
    local confirmgui = gui.useraskGUI.USERAGREE.Frame.responseframe
    local confirm = confirmgui and confirmgui:FindFirstChild("askbutton")
    
    if not confirm then return end
  
    local confirmpos = confirm.AbsolutePosition
    local spinpos = gui.GUI.Spin_Weapons.SpinButtons.Holder.Normal.Txt.AbsolutePosition
    local weapon = cwlabel.Text
    
    mousemoveabs(spinpos.X + 100, spinpos.Y + 25)
    mouse1click()
    task.wait(0.1)
    mouse1release()
    task.wait(0.1)
    mouse1click()
    task.wait(0.1)
    mouse1release()

    for _, v in ipairs(whitelisted) do
        if weapon == v then
            wtime = 1.1
            mousemoveabs(confirmpos.X + 100, confirmpos.Y + 25)
            mouse1click()
            task.wait(0.5)
            mouse1release()
            mousemoveabs(spinpos.X + 100, spinpos.Y + 25)
            mouse1click()
            task.wait(0.1)
            mouse1release()
            wtime = 0.8
            break
        end
    end
    local weapon = cwlabel.Text
    if weapon == "BLINDFOLD" then
        _G.rolling = false
    end
end

task.wait(5)

while _G.rolling and isrbxactive() do
    weaponroll()
    task.wait(wtime)
end
