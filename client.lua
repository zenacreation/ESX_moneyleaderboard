RegisterCommand(Config.CommandName, function()
    -- Trigger server-side event to get the leaderboard data
    TriggerServerEvent('leaderboard:getRichestPlayers')
end)

RegisterNetEvent('leaderboard:receiveTopRichest')
AddEventHandler('leaderboard:receiveTopRichest', function(data)
    local elements = {}

    for i, entry in ipairs(data) do
        -- Add medal for top 3
        local medal = ""
        if i == 1 then
            medal = " 🥇"
        elseif i == 2 then
            medal = " 🥈"
        elseif i == 3 then
            medal = " 🥉"
        end

        -- Format wealth with commas
        local formattedWealth = tostring(entry.wealth):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")

        -- Insert to elements
        table.insert(elements, {
            title = ("#%d - %s%s"):format(i, entry.name, medal),
            description = ("Total Wealth: $%s"):format(formattedWealth),
            icon = "dollar-sign"
        })
    end

    -- Register and show the leaderboard context menu
    lib.registerContext({
        id = 'richest_players_menu',
        title = Config.LeaderboardTitle,
        options = elements
    })

    lib.showContext('richest_players_menu')
end)