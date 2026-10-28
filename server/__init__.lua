require "common/timer"

local gamestarted = false

local function getPlayerCount()
    -- Count up the current human players
    local count = 0

    local players = PlayerManager.GetPlayers()
    if players == nil then 
        return 0
    end

    for _, player in ipairs(players) do
        if player.isBot then
            goto continue
        end

        count = count + 1
            ::continue::
        end

    return count
end

EventManager.Listen("Level:Loaded", function(level, mode)
    gamestarted = false
    SetTimeout(function()
        if getPlayerCount() >= 1 then
            Console.Execute("Kyber.StartGame")
            gamestarted = true
        else
            print("Waiting for a player")
        end
    end, 23.0)
end)

EventManager.Listen("ServerPlayer:Joined", function(joiningPlayer)
    if gamestarted then return end
    if joiningPlayer == nil then return end
    SetTimeout(function()
        Console.Execute("Kyber.startgame")
        gamestarted = true
    end, 20.0)
end)