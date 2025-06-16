return function(Settings)
    local Teams = game:GetService("Teams")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Auto join team
    if Teams:FindFirstChild(Settings.JoinTeam) then
        repeat
            task.wait()
            LocalPlayer.Team = Teams:FindFirstChild(Settings.JoinTeam)
        until LocalPlayer.Team == Teams:FindFirstChild(Settings.JoinTeam)
        print("Joined Team:", Settings.JoinTeam)
    end

    -- Daftar buah mythical
    local MythicalFruits = {"Dragon-Dragon", "Leopard-Leopard", "Kitsune-Kitsune"}

    local function CheckForMythicalFruit()
        local found = false
        for _, fruitName in pairs(MythicalFruits) do
            local fruit = workspace:FindFirstChild(fruitName)
            if fruit then
                found = true
                if Settings.NotifyWhenFound then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Mythical Fruit Found!";
                        Text = "Found: "..fruitName;
                        Duration = 5
                    })
                end
                break
            end
        end
        return found
    end

    -- Loop pencarian
    while Settings.AutoHuntMythicalFruit do
        if CheckForMythicalFruit() then
            print("Mythical fruit found!")
            break
        else
            print("No mythical fruit found in this server.")
            if Settings.ServerHopWhenNoMythical then
                task.wait(2)
                -- Server hopping logic here
                print("Server hopping...")
                break
            else
                task.wait(10)
            end
        end
    end
end
