-- Provides a Table holding the following values
-- 
function SS_DungeonSorter()
	SS_dungeonsbyID = {};
	SS_sortedDungeonsID = {};
	local myLevel = UnitLevel("player");
	local found;
	for i = 1, GetNumRandomDungeons() do
		local dgInfo = { GetLFGRandomDungeonInfo(i) };
		local id, name, mapName = dgInfo[1], dgInfo[2], dgInfo[20];		
		local _, _, _, minLevel, maxLevel, _, _, _, expansionLevel, _, _, difficulty, _,_, isHoliday, _, _, isTimewalk = GetLFGDungeonInfo(id);
		local key = {id = id, name = name, mapName = "Random Dungeons", difficulty = difficulty, timewalking = isTimewalk}
		if(myLevel >= minLevel and myLevel <= maxLevel and EXPANSION_LEVEL >= expansionLevel and (difficulty == 2 or isTimewalk)) then
			tinsert(SS_dungeonsbyID, key)
		end
	end
	for i=1, GetNumRFDungeons() do
		local dgInfo = { GetRFDungeonInfo(i) };
		local id, name, mapName = dgInfo[1], dgInfo[2], dgInfo[20];
		local _, _, hideIfUnmet = IsLFGDungeonJoinable(id);
		local _, typeID, subtypeID, minLevel, maxLevel, _, _, _, expansionLevel, _, _, difficulty = GetLFGDungeonInfo(id);
		local key = {id = id, name = name, mapName = mapName, difficulty=difficulty}
		if(myLevel >= minLevel and myLevel <= maxLevel and EXPANSION_LEVEL >= expansionLevel and not hideIfUnmet) then
			tinsert(SS_dungeonsbyID, key);
		end
	end
	while #SS_dungeonsbyID > #SS_sortedDungeonsID do
		local tmp, key, j = 0;
		for i = 1, #SS_dungeonsbyID do
			if (SS_dungeonsbyID[i].id > tmp) then
				local tooltip, reason, locked;
				local isAvailable, x, y = IsLFGDungeonJoinable(SS_dungeonsbyID[i].id);
				if not isAvailable then
					tooltip = LFGConstructDeclinedMessage(SS_dungeonsbyID[i].id);
					locked = true;
					reason = "Locked by client."
					if string.find(tooltip, "This instance is not available yet") then reason = "Unreleased" end;
					if string.find(tooltip, "You need a higher average item level") then reason = "Low iLVL" end;
				end
				key = {id = SS_dungeonsbyID[i].id, name = SS_dungeonsbyID[i].name, mapName = SS_dungeonsbyID[i].mapName, difficulty = SS_dungeonsbyID[i].difficulty, timewalking = SS_dungeonsbyID[i].timewalking, locked = locked, tooltip = tooltip, reason = reason}
				tmp = SS_dungeonsbyID[i].id;
				j = i;
			end
			if #SS_dungeonsbyID == i then
				tinsert(SS_sortedDungeonsID, 1, key)
				SS_dungeonsbyID[j].id = 0
			end
		end
	end
	for i=1, #SS_sortedDungeonsID do
		if(SS_sortedDungeonsID[i].difficulty == 24 or SS_sortedDungeonsID[i].timewalking) then
			found = true;
			SS_sortedDungeonsID[i].name = "Timewalking";
		else
			if #SS_sortedDungeonsID == i and not found then
				local key = {id = 0, name = "Timewalking", mapName = "Random Dungeons", locked = true, tooltip = "Not available this reset.", reason = "Not active"}
				tinsert(SS_sortedDungeonsID, 2, key)
			end
		end
		if(SS_sortedDungeonsID[i].difficulty == 2 and not SS_sortedDungeonsID[i].timewalking) then
			SS_sortedDungeonsID[i].name = "Random Heroic";
		end
	end
end