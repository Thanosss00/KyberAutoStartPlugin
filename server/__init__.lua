require "common/timer"

local gamestarted = false

local function getPlayerCount()
    -- Count all players, including bots
    local count = 0

    local players = PlayerManager.GetPlayers()
    if players == nil then 
        return 0
    end

    for _, player in ipairs(players) do
        count = count + 1
    end

    return count
end

local function checkPlayers()
    if gamestarted then return end

    if getPlayerCount() >= 1 then
        Console.Execute("Kyber.StartGame")
        gamestarted = true
    else
        SetTimeout(checkPlayers, 5.0) -- checks every 5 seconds if a bot was added
    end
end

EventManager.Listen("Level:Loaded", function(level, mode)
    gamestarted = false
    SetTimeout(function()
        if getPlayerCount() >= 1 then
            Console.Execute("Kyber.StartGame")
            gamestarted = true
        else
            print("Waiting for a player or bot")
            SetTimeout(checkPlayers, 5.0)
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