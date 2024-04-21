--Q1 - Fix or improve the implementation of the below methods

local function releaseStorage(playerId)
	local player = Player(playerId)      --creating a new local reference to the player using the ID number to avoid a potential memory leak
	if player ~= nil                     --check to make sure the reference is actually pointing to something
		player:setStorageValue(1000, -1)
	end
end

function onLogout(playerId)
	local player = Player(playerId)                   --creating a new local reference to the player using the ID number to avoid a potential memory leak
	if player ~= nil                                  --check to make sure the reference is actually pointing to something
		if player:getStorageValue(1000) == 1 then
			addEvent(releaseStorage, 1000, player.Id) --passing down the ID instead of a reference to the player object
			return true                               --moving this inside of the if statement, as I'm assuming the StorageValue must be set correctly in order to have a successful logout
		end
	end
	return false                                      --assuming the logout process will be unsuccessful if it can't find a reference to the player, or the storage value is an unexpected result
end

--Q2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
	-- this method is supposed to print names of all guilds that have less than memberCount max members
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
	for k, v in pairs(result) do                                                       --create a loop to iterate through all the DB results
		local guildName = k.getString("name")                                          --get the name from this particular item rather than the entire result table
		print(guildName)
	end
end

--Q3 - Fix or improve the name and the implementation of the below method

function removePartyMember(playerId, memberId)          --changed to a more descriptive name that explains what the function actually does, and the second parameter to be an ID number instead of a name
	player = Player(playerId)
	if player ~= nil                                    --check to make sure the reference is actually pointing to something
		local party = player:getParty()

		for k,v in pairs(party:getMembers()) do
			local partyMember = Player(memberId)        --create a player object to reference the name against
			if v == partyMember.name then
				party:removeMember(partyMember.Id)      --pass along the ID number of the local reference established earlier
			end
		end
	end
end 