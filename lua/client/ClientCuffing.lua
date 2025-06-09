-- Basic client logic for applying restrictions
CuffingSystem = {}

function CuffingSystem:applyCuffs(target, cuffType)
    if target and target:isAlive() then
        target:getModData().isCuffed = true
        target:getModData().cuffType = cuffType
        if cuffType == "cable" then
            target:getModData().cuffBreakTime = getTimestamp() + (10 * 60)
        end
    end
end

Events.OnPlayerUpdate.Add(function(player)
    if player:getModData().isCuffed then
        player:setBlockMovement(true)
        player:setAllowInventory(false)
        player:setCanAttack(false)
        if player:getModData().cuffType == "cable" and getTimestamp() >= (player:getModData().cuffBreakTime or 0) then
            player:getModData().isCuffed = false
        end
    end
end)
