-- are the devs watching :eye:f

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeadMarker/Extrass/main/Uwuwarebackup.lua", true))()
local Window = Library:CreateWindow("LeadMarker - OPBR")

-- // vars \\ -- 
local plr           = game:GetService("Players").LocalPlayer
local chr 			= plr.Character or plr.CharacterAdded:Wait()
local rootPart      = chr:WaitForChild("HumanoidRootPart")
local http          = game:GetService("HttpService")
local Settings      = {}

-- // Extra \\ -- 
local stat_levels = {
    "StrengthLevel",
    "DefenseLevel",
    "SwordLevel",
    "GunLevel",
}

local quest_table = {}
for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Part") and string.find(v.Name, "Quest") and v:FindFirstChild("ClickDetector") and v:FindFirstChild("QuestGiver") then 
        table.insert(quest_table, v.Name)
    end
end
table.sort(quest_table)

local function upgrade(v)
    local ohInstance1 = game:GetService("Players").LocalPlayer.PlayerValues
    local ohInstance2 = game:GetService("Players").LocalPlayer.PlayerValues.StrengthLevel
    local ohInstance3 = game:GetService("Players").LocalPlayer.PlayerValues.DefenseLevel
    local ohInstance4 = game:GetService("Players").LocalPlayer.PlayerValues.SwordLevel
    local ohInstance5 = game:GetService("Players").LocalPlayer.PlayerValues.GunLevel
    local ohInstance6 = game:GetService("Players").LocalPlayer.PlayerValues[v]
    local ohNumber7 = .5
    game:GetService("ReplicatedStorage").RemoteEvents.StatPoint:InvokeServer(ohInstance1, ohInstance2, ohInstance3, ohInstance4, ohInstance5, ohInstance6, ohNumber7)
end

local function attack()
    pcall(function()
        game:GetService("ReplicatedStorage").RemoteEvents.CombatBase:FireServer()
    end)
end

-- // Main \\ -- 
local main = Window:AddFolder("Main")
local mob_list = {
    ['AkainuQuest'] = 'Akainu',
    ['BanditQuest'] = 'Bandit',
    ['BuggyPirateQuest'] = 'Buggy Pirate',
    ['BuggyQuest'] = 'Buggy D. Clown',
    ['CrocodileQuest'] = 'Crocodile',
    ['DesertBanditQuest'] = 'Desert Bandit',
    ['MarineQuest'] = 'Corupt Marine',
    ['smokerQuest'] = 'Smoker',
    ['yetiQuest'] = 'Yeti'
}

main:AddList({
    text = "Select Quest",
    values = quest_table, 
    callback = function(v)
        Settings["ChosenQuest"] = v 
    end
})

local function findQuest()
    for i,v in pairs(workspace:GetDescendants()) do
        if v.Name == Settings.ChosenQuest and v:IsA("Part") then 
            return v 
        end
    end
end

main:AddToggle({
    text = "Autofarm",
    state = false,
    callback = function(v)
        Settings["autofarm"] = v 
    end
})

main:AddToggle({
    text = "HideName",
    state = false,
    callback = function(v)
        Settings["HideName"] = v 
    end
})

spawn(function()
    while wait() do 
        if Settings.HideName then
            pcall(function()
                if game.Players.LocalPlayer.Character.Head:FindFirstChildWhichIsA("BillboardGui") then 
                    game.Players.LocalPlayer.Character.Head:FindFirstChildWhichIsA("BillboardGui"):Destroy()
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do 
        if Settings.autofarm then
            pcall(function()
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("QuestsGUI") == nil then 
                    repeat wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = findQuest().CFrame
                        fireclickdetector(findQuest().ClickDetector)
                    until plr.PlayerGui:FindFirstChild("QuestsGUI") or not Settings.autofarm
                end

                if game:GetService("Players").LocalPlayer.PlayerValues.Quest.Value == 0 and game.Players.LocalPlayer.PlayerGui:FindFirstChild("QuestsGUI") then 
                    repeat wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = findQuest().CFrame
                        fireclickdetector(findQuest().ClickDetector)
                    until game:GetService("Players").LocalPlayer.PlayerValues.Quest.Value == 1 or not Settings.autofarm
                end
                
                if plr.PlayerGui:FindFirstChild("QuestsGUI") then 
                    for i,v in pairs(game.Workspace.Map.Live:GetChildren()) do
                        if v.Humanoid.Health <= 0 and v.Name == mob_list[Settings.ChosenQuest] then
                            v:Destroy()
                        end

                        if v:IsA('Model') and v.Name == mob_list[Settings.ChosenQuest] and v.Humanoid.Health > 0 then 
                            repeat wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Torso.CFrame
                                attack()
                            until not Settings.autofarm or v.Humanoid.Health <= 0 
                        end
                    end
                end
            end)
        end 
    end
end)

main:AddToggle({
    text = "ChestFarm",
    state = false,
    callback = function(v)
        Settings["ChestFarm"] = v 
    end
})

spawn(function()
    while wait() do 
        if Settings.ChestFarm then
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Map.Chests:GetChildren()) do
                    if v:IsA("Part") and v:FindFirstChild("Taken").Value == false then
                        if Settings.ChestFarm then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                            wait(0.5)
                        end
                    end
                end
            end)
        end
    end
end)

main:AddToggle({
    text = "ToolSniper",
    state = false,
    callback = function(v)
        Settings["ToolSniper"] = v 
    end
})

spawn(function()
    while wait() do 
        if Settings.ToolSniper then
            pcall(function()
                for i,v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChildWhichIsA("BasePart") then 
                        v:FindFirstChildWhichIsA("BasePart").CanCollide = false
                        v:FindFirstChildWhichIsA("BasePart").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end
end)

main:AddToggle({
    text = "MoneyGen",
    state = false,
    callback = function(v)
        Settings["MoneyGen"] = v 
    end
})

spawn(function()
    while wait() do 
        if Settings.MoneyGen then 
            game:GetService("ReplicatedStorage").RemoteEvents.DonateBeli:FireServer(.5)
            if game.Players.LocalPlayer.Backpack:FindFirstChild("MoneyBag") then 
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("MoneyBag"))
                game.Players.LocalPlayer.Character:FindFirstChild("MoneyBag"):Activate()
            end
        end
    end
end)

-- // Teleports Tab \\ -- 
local tele = Window:AddFolder("Teleports")
local npcs = {}
for i,v in pairs(game:GetService("Workspace").Map.NPCs:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("ClickDetector") and v:FindFirstChild("Torso") then 
        table.insert(npcs, v.Name) 
    end
end

tele:AddList({
    text = "Select NPC",
    values = npcs,
    callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.NPCs:FindFirstChild(v).Torso.CFrame
    end
})

local shops = {}
for i,v in pairs(game:GetService("Workspace").Map.Shops:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("ClickDetector") then 
        table.insert(shops, v.Name) 
    end
end

tele:AddList({
    text = "Select SHOP",
    values = shops,
    callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Shops:FindFirstChild(v):GetModelCFrame() 
    end
})
local islands = {}
for i,v in pairs(game:GetService("Workspace").Map.SpawnPoints:GetChildren()) do
    table.insert(islands, v.Name)
end

tele:AddList({
    text = "Select Island",
    values = islands,
    callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.SpawnPoints:FindFirstChild(v).CFrame
    end
})

-- // Credits Tab \\ -- 
local cred = Window:AddFolder("Credits")
cred:AddButton({text = "LeadMarker#1219", callback = function()
    setclipboard("LeadMarker#1219")
end})
cred:AddButton({text = "Discord", callback = function()
    setclipboard("discord.gg/8Cj5abGrNv")
end})

-- // Init \\ -- 
Library:Init()
