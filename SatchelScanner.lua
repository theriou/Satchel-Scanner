--------------------------------
-- Coded by: Exzu / EU-Aszune --
--------------------------------
--     MAINFRAME & SCANNER    --
--------------------------------
-- Satchel IDs
SS_SatchelIDs = {id_160054=0,id_140591=0,id_128803=0,id_90818=0,id_120334=0,id_69903=0,id_184522=0,id_201326=0,id_224573=0}

-- Hardcoded textures
SS_Spacer = "Interface\\Addons\\SatchelScanner\\textures\\hr.tga";
SS_Border = "Interface\\Addons\\SatchelScanner\\textures\\border.tga";
SS_BagIcon = "Interface\\Addons\\SatchelScanner\\textures\\bagIcon.tga";
SS_TankIcon = "Interface\\Addons\\SatchelScanner\\textures\\tankIcon.tga";
SS_HealerIcon = "Interface\\Addons\\SatchelScanner\\textures\\healerIcon.tga";
SS_DpsIcon = "Interface\\Addons\\SatchelScanner\\textures\\dpsIcon.tga";
SS_StartButton = "Interface\\Buttons\\UI-Panel-Button-Up.blp";
SS_StopButton = "Interface\\Buttons\\UI-Panel-Button-Up.blp";
SS_preFont = "Interface\\Addons\\SatchelScanner\\fonts\\font.TTF";
SS_highlightSmallUI = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp";
SS_hightlightMediumUI = "Interface\\Buttons\\UI-Panel-Button-Highlight.png";
SS_ConfigButtonPush = "Interface\\Addons\\SatchelScanner\\textures\\configpush.tga";
SS_CloseButtonPush = "Interface\\Addons\\SatchelScanner\\textures\\closepush.tga";
SS_ConfigButton = "Interface\\Addons\\SatchelScanner\\textures\\config.tga";
SS_CloseButton = "Interface\\Addons\\SatchelScanner\\textures\\close.tga";

-- Variables
local running = false;
SS_addonVersion = 1117.0;
SS_versionTag = "Release";
SS_TimeSinceLastNotification = 0;

-- Dungeon Scan Var
SS_runVar = {"Not Running", "Running"};
SS_classScan = {"Not Scanning...","Scanning...","Satchel Found!"};
SS_ctaVar = {"Call to Arms: Tank","Call to Arms: Healer","Call to Arms: Dps"};

-- Text Colors
local redColor = {1,0,0,1};
local greenColor = {0,1,0,1};
local yellowColor = {1,1,0,1};
local whiteColor = {1,1,1,1};
local SS_Loaded = false;

local category, layout;

SS_ChildFrameTable = {
	[1] = { x = 5,
		[1] = { "Icon", x = 5, texture = SS_TankIcon, },
		[2] = { "Text", x = 22, color = {1, 1, 1, 1}, text = "Tank:", },
		[3] = { "Text2", x = 50, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	},
	[2] = { x = 5,
		[1] = { "Icon", x = 5, texture = SS_HealerIcon, },
		[2] = { "Text", x = 22, color = {1, 1, 1, 1}, text = "Heal:", },
		[3] = { "Text2", x = 49, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	},
	[3] = { x = 5,
		[1] = { "Icon", x = 5, texture = SS_DpsIcon, },
		[2] = { "Text", x = 22, color = {1, 1, 1, 1}, text = "DPS:", },
		[3] = { "Text2", x = 46, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	},
};

SS_CoreFrameTable = {
	SS_HeaderText = { loc = "TOP", x = 0, y = 8, fontSize = "14", color = {1, 1, 1, 1}, text = "Satchel Scanner", },
	SS_SubHeaderText = { loc = "TOPLEFT", x = 5, y = -5, fontSize = "16", color = {0, 1, 0, 1}, text = "Current Status:", },
	SS_SubHeaderText2 = { loc = "TOPLEFT", x = 95, y = -5, fontSize = "16", color = {1, 0, 0, 1}, text = "Not Running", },
	SS_configButton = { loc = "TOP", x = 97, y = -5, width = "16", height = "16", functionName = "Settings.OpenToCategory(category.ID)", texture = SS_ConfigButton, pushedTxt = SS_ConfigButtonPush, highLightTxt = SS_highlightSmallUI},
	SS_closeButton = { loc = "TOP", x = 115, y = -5, width = "16", height = "16", functionName = "SS_hideMainFrame()", texture = SS_CloseButton, pushedTxt = SS_CloseButtonPush, highLightTxt = SS_highlightSmallUI},
	SS_HeaderSpacertexture = { loc = "TOP", x = 0, y = -23, width = "0" , height = "2", texture = SS_Spacer},
	SS_bagIcontexture = { loc = "TOP", x = 79, y = -5, width = "16", height = "16", texture = SS_BagIcon},
	SS_bagCounterText = { loc = "TOP", x = 60, y = -7, fontSize = "14", color = {0, 0.6, 0.8, 1}, text = "0"},
	SS_startButton = { loc = "BOTTOM", x = -85, y = 5, text = "Start", yscale = 22/32, xscale = 80/130, width = "80", height = "25", functionName = "SS_startScanning()", texture = SS_StartButton, pushedTxt = "Interface\\Buttons\\UI-Panel-Button-Down.blp", highLightTxt = SS_hightlightMediumUI},
	SS_stopButton = { loc = "BOTTOM", x = 85, y = 5, text = "Stop", yscale = 22/32, xscale = 80/130, width = "80", height = "25", functionName = "SS_stopScanning()", texture = SS_StopButton, pushedTxt = "Interface\\Buttons\\UI-Panel-Button-Down.blp", highLightTxt = SS_hightlightMediumUI},
};

function SS_UpdateChildFrame()
	local role = {"Tank","Heal","Dps"}
	if not SS_Globals["SS_RoleIconDps"] and not running then
		for j, var in ipairs(SS_ChildFrameTable) do -- This register all frames and hides them
			for i, tVar in ipairs(var) do
				if string.find(tVar[1] or "", "Text") and not SS_Globals["SS_RoleText"..role[j].."#"..i] then
					SS_Globals["SS_RoleText"..role[j].."#"..i] = SatchelScannerDisplayWindow:CreateFontString(nil, "OVERLAY")
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetFont(SS_preFont, 14, "OUTLINE");
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetTextColor(unpack(tVar.color));
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetText(tVar.text);
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetPoint("TOPLEFT", 0, 0);
					SS_Globals["SS_RoleText"..role[j].."#"..i]:Hide();
				elseif string.find(tVar[1] or "", "Icon") and not SS_Globals["SS_RoleIcon"..role[j]] then
					SS_Globals["SS_RoleIcon"..role[j]] = CreateFrame("Button", nil, SatchelScannerDisplayWindow, BackdropTemplateMixin and "BackdropTemplate");
					SS_Globals["SS_RoleIcon"..role[j]]:SetWidth("16");
					SS_Globals["SS_RoleIcon"..role[j]]:SetHeight("16");
					SS_Globals["SS_RoleIcon"..role[j]]:SetNormalTexture(tVar.texture)
					SS_Globals["SS_RoleIcon"..role[j]]:SetPoint("TOPLEFT", 0, 0);
					SS_Globals["SS_RoleIcon"..role[j]]:Hide();
				end
			end
			for k=1, #SS_sortedDungeonsID do
				local nameVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].name, " ", ""))
				nameVar = string.gsub(nameVar, "'", "")
				SS_Globals[nameVar..role[j]] = SatchelScannerDisplayWindow:CreateFontString(nil, "OVERLAY")
				SS_Globals[nameVar..role[j]]:SetFont(SS_preFont, 14, "OUTLINE");
				SS_Globals[nameVar..role[j]]:SetTextColor(1,1,1,1);
				SS_Globals[nameVar..role[j]]:SetText("# ...");
				SS_Globals[nameVar..role[j]]:SetPoint("TOPLEFT", 0, 0);
				SS_Globals[nameVar..role[j]]:Hide();
			end
		end
	end
	if SS_Globals["SS_RoleIconDps"] and not running then
		local yvar = -28;
		for j, var in ipairs(SS_ChildFrameTable) do -- This is for displaying/hiding each texture
			local countMe = 0;
			for i, tVar in ipairs(var) do
				if string.find(tVar[1] or "", "Text") then
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetPoint("TOPLEFT", tVar.x, yvar);
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetText(tVar.text);
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetTextColor(unpack(tVar.color));
					SS_Globals["SS_RoleText"..role[j].."#"..i]:Show();
					if string.find(tVar[1] or "", "Text2") then
						yvar = yvar - 17;
					end
				elseif string.find(tVar[1] or "", "Icon") then
					SS_Globals["SS_RoleIcon"..role[j]]:SetPoint("TOPLEFT", tVar.x, yvar);
					SS_Globals["SS_RoleIcon"..role[j]]:Show();
					yvar = yvar - 1;
				end
			end
			for k=1, #SS_sortedDungeonsID do
				local nameVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].name, " ", ""))
				nameVar = string.gsub(nameVar, "'", "")
				if(SS_Globals.dungeonData[nameVar.."Box"..j]:GetChecked()) then
					countMe = countMe + 1;
					SS_Globals[nameVar..role[j]]:Hide()
				elseif not (SS_Globals.dungeonData[nameVar.."Box"..j]:GetChecked()) then
					SS_Globals[nameVar..role[j]]:Hide()
				end
				
			end
			if countMe == 0 then
				yvar = yvar + 18;
				SS_Globals["SS_RoleText"..role[j].."#"..3]:Hide();
				SS_Globals["SS_RoleText"..role[j].."#"..2]:Hide();
				SS_Globals["SS_RoleIcon"..role[j]]:Hide();
			end
			local heigth = (yvar*-1) + 30;
			SatchelScannerDisplayWindow:SetHeight(heigth);
		end
	end
	if SS_Globals["SS_RoleIconDps"] and running then
		local yvar = -28;
		for j, var in ipairs(SS_ChildFrameTable) do
			for i, tVar in ipairs(var) do
				if string.find(tVar[1] or "", "Text") and SS_Globals["SS_RoleText"..role[j].."#"..i]:IsShown() then
					SS_Globals["SS_RoleText"..role[j].."#"..i]:SetPoint("TOPLEFT", tVar.x, yvar);
					if string.find(tVar[1] or "", "Text2") then
						yvar = yvar - 17;
					end
				elseif string.find(tVar[1] or "", "Icon") then
					SS_Globals["SS_RoleIcon"..role[j]]:SetPoint("TOPLEFT", tVar.x, yvar);
					yvar = yvar - 1;
				end
			end
			for k=1, #SS_sortedDungeonsID do
				local nameVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].name, " ", ""))
				nameVar = string.gsub(nameVar, "'", "")
				if(SS_Globals[nameVar..role[j]]:IsShown()) then
					SS_Globals[nameVar..role[j]]:SetPoint("TOPLEFT", var.x, yvar);
					yvar = yvar - 15;
				end
			end
			local heigth = (yvar*-1) + 30;
			SatchelScannerDisplayWindow:SetHeight(heigth);
		end		
	end
	SS_bagCounterText:SetText(SS_satchelsReceived);
end

-- Scanner, Scans for available Satchels
function SS_Scanner()
	if (SS_Globals["SS_RoleIconDps"]) and running then
		for j, var in ipairs(SS_ChildFrameTable) do
			local role = {"Tank","Heal","Dps"}
			local SatchelFound;
			for k=1, #SS_sortedDungeonsID do
				local nameVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].name, " ", ""))
				nameVar = string.gsub(nameVar, "'", "")
				local completed = false;
				if(SS_sortedDungeonsID[k].mapName == "Random Dungeons") and SS_Globals.SS_CompleteLFGOnce then
					completed = GetLFGDungeonRewards(SS_sortedDungeonsID[k].id);
				elseif(SS_sortedDungeonsID[k].difficulty == 17) and SS_Globals.SS_CompleteLFROnce then
					completed = GetLFGDungeonRewards(SS_sortedDungeonsID[k].id);
				end
				if (SS_Globals.dungeonData[nameVar.."Box"..j]:GetChecked() and not completed) then
					local fastScan = {};
					local eligible, forTank, forHeal, forDps = GetLFGRoleShortageRewards(SS_sortedDungeonsID[k].id, 1)
					local fastScan = { forTank, forHeal, forDps };
					if fastScan[j] then
						SS_Globals[nameVar..role[j]]:SetTextColor(unpack(greenColor));
						SS_Globals[nameVar..role[j]]:SetText("# "..SS_sortedDungeonsID[k].name);
						SS_Globals[nameVar..role[j]]:Show();
						SS_NotifcationTable[j] = true;
						SatchelFound = true;
					elseif not fastScan[j] then
						SS_Globals[nameVar..role[j]]:SetTextColor(unpack(whiteColor));
						SS_Globals[nameVar..role[j]]:SetText("# Searching...");
						SS_Globals[nameVar..role[j]]:Hide();
					end
				end
			end
			if SatchelFound then
				SS_Globals["SS_RoleText"..role[j].."#3"]:SetTextColor(unpack(greenColor));
				SS_Globals["SS_RoleText"..role[j].."#3"]:SetText(SS_classScan[3]);
			else
				SS_Globals["SS_RoleText"..role[j].."#3"]:SetTextColor(unpack(yellowColor));
				SS_Globals["SS_RoleText"..role[j].."#3"]:SetText(SS_classScan[2]);
			end
		end
		SS_UpdateChildFrame();
		if SS_NotifcationTable[1] or SS_NotifcationTable[2] or SS_NotifcationTable[3] then
			SatchelScanner_Notify();
		end
	end
end

-- Called after Interface Panels have been setup
function SS_SetupCoreFrame() -- Will be used for minimalist option later.
	SatchelScannerDisplayWindow = CreateFrame("Frame", "SatchelFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	SatchelScannerDisplayWindow:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = SS_Border,
	tile = true,
	tileEdge = true,
	tileSize = 12,
	edgeSize = 8,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
	});
	SatchelScannerDisplayWindow:SetBackdropColor(0, 0, 0, 0.8);
	SatchelScannerDisplayWindow:SetMovable(true)
	SatchelScannerDisplayWindow:EnableMouse(true)
	SatchelScannerDisplayWindow:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and not self.isMoving then
			self:StartMoving();
			self.isMoving = true;
		end
	end)
	SatchelScannerDisplayWindow:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing();
			self:SetUserPlaced(false);
			self.isMoving = false;
			SatchelScannerDB["MainFrameLoc"] = {SatchelScannerDisplayWindow:GetPoint();}
		end
	end)
	SatchelScannerDisplayWindow:SetScript("OnHide", function(self)
		if ( self.isMoving ) then
			self:StopMovingOrSizing();
			self.isMoving = false;
		end
	end)
	SatchelScannerDisplayWindow:SetWidth(260);
	SatchelScannerDisplayWindow:SetHeight(60);
	SatchelScannerDisplayWindow:SetFrameStrata("BACKGROUND")
	for i, tVar in pairs(SS_CoreFrameTable) do
		if string.find(i, "Button") then
			_G[i] = CreateFrame("Button", nil, SatchelScannerDisplayWindow, UIPanelButtonTemplate, BackdropTemplateMixin and "BackdropTemplate");
			_G[i]:SetWidth(tVar.width);
			_G[i]:SetHeight(tVar.height);
			_G[i]:SetPoint(tVar.loc, tVar.x, tVar.y);
			_G[i]:SetNormalTexture(tVar.texture);
			_G[i]:SetPushedTexture(tVar.pushedTxt);
			_G[i]:SetHighlightTexture(tVar.highLightTxt);
			_G[i]:SetScript("OnClick", loadstring(tVar.functionName))
			if string.find(i, "start") or string.find(i, "stop") then
				_G[i]:GetNormalTexture():SetTexCoord(0,tVar.xscale,0,tVar.yscale);
				_G[i]:GetPushedTexture():SetTexCoord(0,tVar.xscale,0,tVar.yscale);
				_G[i]:GetHighlightTexture():SetTexCoord(0,tVar.xscale,0,tVar.yscale);
				if tVar.text then
					local buttonText = _G[i]:CreateFontString(nil, "OVERLAY")
					buttonText:SetFont(SS_preFont, 14, "");
					buttonText:SetPoint("CENTER", 0, 0);
					buttonText:SetTextColor(unpack(yellowColor));
					buttonText:SetText(tVar.text);
				end
			end
		elseif string.find(i, "texture") then
			_G[i] = CreateFrame("Button", nil, SatchelScannerDisplayWindow, BackdropTemplateMixin and "BackdropTemplate");
			_G[i]:SetWidth(tVar.width);
			_G[i]:SetHeight(tVar.height);
			_G[i]:SetPoint(tVar.loc, tVar.x, tVar.y);
			_G[i]:SetNormalTexture(tVar.texture)
			if string.find(i, "Spacer") then
				_G[i]:SetWidth(SatchelScannerDisplayWindow:GetWidth() - 14);
				_G[i]:SetAlpha(1);
			end
		elseif string.find(i, "Text") then
			_G[i] = SatchelScannerDisplayWindow:CreateFontString(nil, "OVERLAY")
			_G[i]:SetFont(SS_preFont, tVar.fontSize, "OUTLINE");
			_G[i]:SetPoint(tVar.loc, tVar.x, tVar.y);
			_G[i]:SetTextColor(unpack(tVar.color));
			_G[i]:SetText(tVar.text);
		end
	end
	SS_datacall("read");
	SS_UpdateChildFrame();
	--Check for Auto Scan now that addon ui is loaded
	if SS_Globals.SS_autoScan then
		SS_startScanning();
	end
end

function SS_startScanning()
	if not running then
		running = true
		SS_SubHeaderText2:SetText(SS_runVar[2]);
		SS_SubHeaderText2:SetTextColor(unpack(greenColor));
		SS_UpdateChildFrame();
		RequestLFDPlayerLockInfo();
		SS_printmm("Started Scanning!");
	end
	SS_datacall("update");
end

function SS_stopScanning()
	if running then
		running = false;
		SS_SubHeaderText2:SetText(SS_runVar[1]);
		SS_SubHeaderText2:SetTextColor(unpack(redColor));
		SS_UpdateChildFrame();
		SS_printmm("Stopped Scanning!")
	end
	SS_datacall("update");
end

function SS_hideMainFrame()
	SatchelScannerDisplayWindow:Hide();
	SS_showUI = false;
	SatchelScannerDB["showMainFrame"] = SS_showUI;
end

-------------------------------
-- PRINT, ERROR COLLECT ETC. --
-------------------------------
function SS_errorCollect(e, e2)
	print("|cffff0000==== SS3 ERROR DUMP ====");
	print("|cFF0080FFSS3: |cffffffffINVALID '"..e.."' CALL");
	print("|cFF0080FFSS3: |cffffffffCALL USED WAS: '"..e2.."'");
	print("|cFF0080FFSS3: |cffffffffPLEASE REPORT TO DEVELOPER");
	print("|cffff0000==== END OF SS3 DUMP ====");
end

function SS_printm(msg)
	print("|cFFFF007F" .. msg  .. "|r");
end

function SS_printmm(msg)
	print("|cFF0080FFSS3: |cffffffff"..msg.."|r");
end

----------------------------------
-- ON LOAD, ON UPDATE, ON EVENT --
----------------------------------

function SatchelScanner_OnEvent(self, event, arg)
	local SS_inLFGQueue = GetLFGQueueStats(LE_LFG_CATEGORY_LFD)
	local SS_inLFRQueue = GetLFGQueueStats(LE_LFG_CATEGORY_RF)
	local SS_debuff = AuraUtil.FindAuraByName("Dungeon Deserter", "player")
	local SS_inGroup = IsInGroup()
	if event == "ADDON_LOADED" and arg == "SatchelScanner" then
		SS_Globals = {dungeonData = {}, frameText = {}, panelText = {}};
		SS_NotifcationTable = {};
		SS_printmm("Satchel Scanner v"..SS_addonVersion);
		SS_printmm("->> Type /ss3 for commands!");
		SS_Loaded = true;
	elseif event == "CHAT_MSG_LOOT" and not (MailFrame:IsShown() or TradeFrame:IsShown()) then
		local loot = string.match(arg, "item:(%d+):");
		if(loot) then	
			if(SS_SatchelIDs["id_"..loot]) then	
				SS_satchelsReceived = SS_satchelsReceived + 1;
				SS_bagCounterText:SetText(SS_satchelsReceived);
				SS_datacall("update");
			end
		end
	elseif event == "LFG_QUEUE_STATUS_UPDATE" then
		-- This is just thrown to make sure SS_inLFGQueue/SS_inLFRQueue works as intended.
		-- Mostly to keep the booleans true/false even after an Que rejoin.
		-- This was an old fix, unsure if still needed, left behind for now.
	elseif event == "PLAYER_ENTERING_WORLD" then
		ss_inInstance = IsInInstance()
	elseif event == "LFG_UPDATE_RANDOM_INFO" and running and not SS_inLFGQueue and not SS_inLFRQueue and not string.find(SS_debuff or "", "Dungeon Deserter") and (SS_scanInDungeon or not ss_inInstance) and (SS_scanInGroup or not SS_inGroup) then
		SS_Scanner();
	elseif event == "LFG_UPDATE_RANDOM_INFO" and SS_Loaded and not running then
		SS_Loaded = false;
		SS_DungeonSorter();
		SS_interfaceConfig();
	end
end

function SatchelScanner_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("CHAT_MSG_LOOT");
	self:RegisterEvent("LFG_UPDATE_RANDOM_INFO");
	self:RegisterEvent("LFG_QUEUE_STATUS_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	SLASH_SATCHELSCANNER1, SLASH_SATCHELSCANNER2 = "/satchelscan", "/ss3"
	SlashCmdList.SATCHELSCANNER = function(fmsg)
		local msg, arg1 = strsplit(" ",fmsg)
		if msg == "toggle" then
			if SatchelScannerDisplayWindow:IsShown() then
				SatchelScannerDisplayWindow:Hide();
				SS_showUI = false;
			else
				SatchelScannerDisplayWindow:Show();
				SS_showUI = true;
			end
			SS_datacall("update");
		elseif msg == "start" then
			SS_startScanning();
		elseif msg == "stop" then
			SS_stopScanning();
		elseif msg == "reset" then
			SS_satchelsReceived = SatchelScannerDB["satchels"];
			SS_datacall("reset");
		elseif msg == "bagcounter" then
			if(arg1 == nil) then
				SS_printmm("Proper Usage: '/ss3 bagcounter X' where X is a number or '/ss3 bagcounter reset'");
			elseif string.find(arg1, "reset") then
				SS_satchelsReceived = 0;
				SS_datacall("update");
			elseif (tonumber(arg1) and math.floor(arg1) and not string.find(arg1, "-")) then
				arg1 = math.abs(arg1);
				if(arg1 < 99999) then
					SS_satchelsReceived = arg1;
					SS_datacall("update");
				else
					SS_printmm("You cannot set a number higher than 99'999 or lower than 0");
				end
			end
		elseif msg == "config" then
			Settings.OpenToCategory(category.ID)
		elseif msg == "faq" then
			Settings.OpenToCategory(category.ID)
		else
			print("|cffffffff========== |cFF0080FFSatchel Scanner |cffffffff==========|r");
			SS_printmm("->> Use '/ss3 toggle' to show/hide the frame");
			SS_printmm("->> Use '/ss3 start' to start scanning");
			SS_printmm("->> Use '/ss3 stop' to stop scanning");
			SS_printmm("->> Use '/ss3 reset' to reset the addon");
			SS_printmm("->> Use '/ss3 bagcounter reset or <0-99'999>' to set the bag counter");
			SS_printmm("->> Use '/ss3 config' to configure the addon");
			SS_printmm("->> Use '/ss3 faq' to open the F.A.Q")
		end
		msg = ""
	end
end

function SatchelScanner_Notify()
	if running then
		local timeSinceLast = GetTime(); -- GetTime(): KERNEL FUNCTION, KEEP IN MIND USES GetTickCount()!
		timeSinceLast = timeSinceLast - SS_TimeSinceLastNotification;
		if (timeSinceLast > SS_NotificationInterval) then
			FlashClientIcon();
			if SS_Globals.SS_raidWarnNotify then
				for i=1,3,1 do
					if SS_NotifcationTable[i] then
						RaidNotice_AddMessage(RaidWarningFrame, SS_ctaVar[i], ChatTypeInfo["RAID_WARNING"])
						SS_NotifcationTable[i] = false;
					end
				end
			end
			if not SatchelScannerDisplayWindow:IsShown() then
				SatchelScannerDisplayWindow:Show();
			end
			if SS_Globals.SS_playSound then
				PlaySound(SOUNDKIT.RAID_WARNING, "Master");
			end
			SS_TimeSinceLastNotification = GetTime();
		end
	end
end

function SatchelScanner_OnUpdate(self, elapsed)
	if running then
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
		while (self.TimeSinceLastUpdate > SS_ScannerInterval) do
			RequestLFDPlayerLockInfo();
			self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - SS_ScannerInterval;
		end
	end
end