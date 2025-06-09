Events.OnFillInventoryObjectContextMenu.Add(function(player, context, items)
    local target = getSpecificPlayer(0) -- simplified for now

    if target and target:getModData().isCuffed then
        local inv = player:getInventory()
        if inv:contains("HandcuffKey") then
            context:addOption("Unlock (Key)", nil, function()
                target:getModData().isCuffed = false
            end)
        elseif inv:contains("Scissors") and target:getModData().cuffType == "cable" then
            context:addOption("Cut Cable Ties", nil, function()
                target:getModData().isCuffed = false
            end)
        elseif inv:contains("Rock") and target:getModData().cuffType == "metal" then
            context:addOption("Smash Cuffs", nil, function()
                if ZombRand(100) < 50 then
                    target:getModData().isCuffed = false
                end
            end)
        end

        context:addOption("Search Inventory", nil, function()
            ISTimedActionQueue.add(ISInventoryTransferAction:new(player, target:getInventory(), player:getInventory(), 50))
        end)
    end
end)
