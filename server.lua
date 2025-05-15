local oxmysql = exports.oxmysql
Config = Config or {} -- ensure Config is accessible

-- Fallbacks if Config is not loaded properly
local TopCount = Config.TopCount or 10

RegisterServerEvent('leaderboard:getRichestPlayers')
AddEventHandler('leaderboard:getRichestPlayers', function()
    oxmysql:query('SELECT identifier, firstname, lastname, accounts FROM users', {}, function(users)
        if not users or #users == 0 then
            print('[zena_money_leaderboard] No users found in database.')
            return
        end

        local wealthData = {}

        for _, user in ipairs(users) do
            if user.accounts then
                local accounts = json.decode(user.accounts)
                if accounts then
                    local money = tonumber(accounts.money or 0)
                    local bank = tonumber(accounts.bank or 0)
                    local totalWealth = money + bank

                    table.insert(wealthData, {
                        name = (user.firstname or 'Unknown') .. ' ' .. (user.lastname or ''),
                        wealth = totalWealth
                    })
                end
            end
        end

        -- Sort and select top richest players
        table.sort(wealthData, function(a, b)
            return a.wealth > b.wealth
        end)

        local top = {}
        for i = 1, math.min(TopCount, #wealthData) do
            table.insert(top, wealthData[i])
        end

        -- Send leaderboard to all clients
        TriggerClientEvent('leaderboard:receiveTopRichest', -1, top)
    end)
end)
