--------------------------------
-- Coded by: Exzu / EU-Aszune --
--------------------------------
--   INTERFACE CONFIG FRAME   --
--------------------------------
-- Hardcoded Textures used in Interface Panel.
SS_TankTexture = "Interface\\Addons\\SatchelScanner\\textures\\tank.tga";
SS_HealTexture = "Interface\\Addons\\SatchelScanner\\textures\\healer.tga";
SS_DpsTexture = "Interface\\Addons\\SatchelScanner\\textures\\dps.tga";

SS_InstanceNewsTable = {
	SS_UpcomingRaidReleaseDate = "Release: MONTH/DATE",
};

SS_optionsTable2 = {
	[1] = { parent = "main", pname = "Satchel Scanner", frame = "SS_ScannerMain",
		SS_TextHeader = { loc = "TOP", x = 0, y = -5, fontSize = 28, text = "|cFF0080FFSatchel Scanner|r"},
		SS_TextSubHeader = { loc = "TOP", x = 0, y = -30, fontSize = 14, text = "Created by Exzu-Aszune"},
		SS_aboutText1 = { loc = "TOP", x = 0, y = -55, fontSize = 24, text = "|cffff0000Questions and Answers|r"},
		SS_aboutTextQ1 = { loc = "TOPLEFT", x = 10, y = -84, fontSize = 16, text = "|cFF0080FFQ: Why does it list an satchel as available when there's nothing shown in the LFG window?|r"},
		SS_aboutTextA1 = { loc = "TOPLEFT", x = 10, y = -100, fontSize = 16, text = "A: This may be because your in a group. You will have to leave your group to view available rewards."},
		SS_aboutTextQ2 = { loc = "TOPLEFT", x = 10, y = -124, fontSize = 16, text = "|cFF0080FFQ: Can you really recieve an satchel as DPS?|r"},
		SS_aboutTextA2 = { loc = "TOPLEFT", x = 10, y = -140, fontSize = 16, text = "A: Yes. It may be uncommon, but it does exist."},
		SS_aboutTextQ3 = { loc = "TOPLEFT", x = 10, y = -164, fontSize = 16, text = "|cFF0080FFQ: I'm having an odd issue that only seems to be occuring for me, solution?|r"},
		SS_aboutTextA3	= { loc = "TOPLEFT", x = 10, y = -180, fontSize = 16, text = "A: Try using '/ss3 reset' to reset all options to default."},
		SS_aboutTextQ4 = { loc = "TOPLEFT", x = 10, y = -204, fontSize = 16, text = "|cFF0080FFQ: Will you add the option to Auto-Queue when an Satchel is available?|r"},
		SS_aboutTextA4 = { loc = "TOPLEFT", x = 10, y = -220, fontSize = 16, text = "A: No, this will never happen. However I plan on adding an 'Quick-Queue' that requires userinput."},
		SS_Spacer0 = { loc = "TOP", x = 0, y = -80, width = "0" , height = "2", texture = SS_Spacer},
		SS_Spacer1 = { loc = "TOP", x = 0, y = -120, width = "0" , height = "2", texture = SS_Spacer},
		SS_Spacer2 = { loc = "TOP", x = 0, y = -160, width = "0" , height = "2", texture = SS_Spacer},
		SS_Spacer3 = { loc = "TOP", x = 0, y = -200, width = "0" , height = "2", texture = SS_Spacer},
		SS_Spacer4 = { loc = "TOP", x = 0, y = -240, width = "0" , height = "2", texture = SS_Spacer},
	};
	[2] = { parent = "options", pname = "Options", frame = "SS_ScannerOptions",
		SS_optionsTextHeader = { fontSize = 24, loc = "TOP", x = 0, y = -5, text = "|cFF0080FFSatchel Scanner|r"},
		SS_optionsTextSubHeader = { fontSize = 18, loc = "TOP", x = 0, y = -25, text = "|cffff0000Scanner Options|r"},
		SS_Spacer5 = { loc = "TOP", x = 0, y = -45, width = "0" , height = "2", texture = SS_Spacer},
		-- BoxText
		SS_optionText1 = { loc = "TOPLEFT", x = 10, y = -50, fontSize = 16, text = "|cffff0000Scan Options|r"},
		SS_optionText2 = { loc = "TOPLEFT", x = 30, y = -70, fontSize = 14, text = "Scan while in a Instance"},
		SS_optionText3 = { loc = "TOPLEFT", x = 30, y = -90, fontSize = 14, text = "Scan while in a Group"},
		SS_optionText4 = { loc = "TOPLEFT", x = 250, y = -70, fontSize = 14, text = "Disable gear check"},
		SS_optionText5 = { loc = "TOPLEFT", x = 250, y = -90, fontSize = 14, text = "Disable class check"},
		SS_optionText6 = { loc = "TOPLEFT", x = 250, y = -110, fontSize = 14, text = "LFR Complete once"},
		SS_optionText7 = { loc = "TOPLEFT", x = 250, y = -130, fontSize = 14, text = "LFG Complete once"},
		SS_optionText8 = { loc = "TOPLEFT", x = 10, y = -170, fontSize = 16, text = "|cffff0000Notification Options|r"},
		SS_optionText9 = { loc = "TOPLEFT", x = 30, y = -190, fontSize = 14, text = "Play Soundwarning"},
		SS_optionText10 = { loc = "TOPLEFT", x = 30, y = -210, fontSize = 14, text = "Show Raidwarning"},
		-- SliderText
		SS_sliderText1 = { loc = "TOPLEFT", x = 145, y = -132, fontSize = 16, text = ""},
		SS_sliderText2 = { loc = "TOPLEFT", x = 10, y = -115, fontSize = 14, text = "Scan Interval in Seconds"},
		SS_sliderText3 = { loc = "TOPLEFT", x = 145, y = -252, fontSize = 16, text = ""},
		SS_sliderText4 = { loc = "TOPLEFT", x = 10, y = -235, fontSize = 14, text = "Notification Interval in Seconds"},
		-- Sliders
		SS_ScannerIntervalSlider = { loc = "TOPLEFT", x = 10, y = -130, width = 130, height = 20, minMax = {3, 30}, valueStep = 1, func = "SS_Globals.SS_sliderText1:SetText(SS_Globals.SS_ScannerIntervalSlider:GetValue())"},
		SS_NotificationIntervalSlider = { loc = "TOPLEFT", x = 10, y = -250, width = 130, height = 20, minMax = {3, 60}, valueStep = 1, func = "SS_Globals.SS_sliderText3:SetText(SS_Globals.SS_NotificationIntervalSlider:GetValue())"},
		-- Boxes
		SS_playSoundButton = { loc = "TOPLEFT", x = 8, y = -185, tooltip = "Plays a sound if an Satchel is found"},
		SS_raidWarningButton = { loc = "TOPLEFT", x = 8, y = -205, tooltip = "Shows a raidwarning if an Satchel is found"},
		SS_scanInDungeonButton = { loc = "TOPLEFT", x = 8, y = -65, tooltip = "Scans while in an instance, this is not shown in the Blizzard UI (You must leave the instance to be able to enlist for the reward)"},
		SS_scanInGroupButton = { loc = "TOPLEFT", x = 8, y = -85, tooltip = "Scans while in a group, this is not shown in the Blizzard UI (You must leave your group to be able to enlist for the reward)"},
		SS_DisableGearButton = { loc = "TOPLEFT", x = 228, y = -65, tooltip = "Scan for Dungeons/LFR-Wings roles you cannot queue for (Not yet implented)"},
		SS_DisableClassButton = { loc = "TOPLEFT", x = 228, y = -85, tooltip = "Scan for Dungeons/LFR-Wings you do not have the gear to queue for (Not yet implented)"},
		SS_CompleteLFROnceButton = { loc = "TOPLEFT", x = 228, y = -105, tooltip = "Only scan for LFR wings you havent completed this week"},
		SS_CompleteLFGOnceButton = { loc = "TOPLEFT", x = 228, y = -125, tooltip = "Only scan for LFGs you havent completed today (This include Timewalking)"},
	};
	[3] = { parent = "instances", pname = "Instances", frame = "SS_ScannerInstances",
		SS_InstanceSpacer10 = { loc = "TOP", x = 0, y = -45, width = "0" , height = "2", texture = SS_Spacer},
		SS_InstanceSpacer11 = { loc = "TOP", x = 0, y = -130, width = "0" , height = "2", texture = SS_Spacer},
		SS_InstanceTextHeader = { fontSize = 24, loc = "TOP", x = 0, y = -5, text = "|cFF0080FFSatchel Scanner|r"},
		SS_InstanceTextSubHeader = { fontSize = 18, loc = "TOP", x = 0, y = -25, text = "|cffff0000Instance Options|r"},
		SS_InstancetankIconText = { text = "Tank", loc = "TOP", x = -148, y = -110, fontSize = 14},
		SS_InstancehealIconText = { text = "Heal", loc = "TOP", x = 2, y = -110, fontSize = 14},
		SS_InstancedpsIconText = { text = "Dps", loc = "TOP", x = 152, y = -110, fontSize = 14},
		SS_InstancetankBigIcon = { loc = "TOP", x = -150, y = -50, width = "64", height = "64", texture = SS_TankTexture},
		SS_InstancehealBigIcon = { loc = "TOP", x = 0, y = -50, width = "64", height = "64", texture = SS_HealTexture},
		SS_InstancedpsBigIcon = { loc = "TOP", x = 150, y = -50, width = "64", height = "64", texture = SS_DpsTexture},
		SS_InstanceRandomDungeonText = { text = "|cffff0000Random Dungeons|r", loc = "TOP", x = 0, y = -135, fontSize = 14},
		-- Dungeons
		SS_InstanceTrigger = { y = -135, loc = "TOP", x = 0, width = "0", height = "2", texture = SS_Spacer},
	};
};	

SS_optionsPanelBackdrop = { 
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}

----------------------------
-- ADDONS/INTERFACE PANEL --
----------------------------

function SS_RegisterText(var, parent, fontSize, loc, x, y, text, anchor)
	SS_Globals[var] = SS_Globals[parent]:CreateFontString(nil, "OVERLAY")
	if anchor then
		SS_Globals[var]:SetParent(anchor);
	end
	SS_Globals[var]:SetFont(SS_preFont, fontSize, "THINOUTLINE");
	SS_Globals[var]:SetPoint(loc, x, y);
	SS_Globals[var]:SetText(text);
end
function SS_RegisterSlider(var, parent, width, height, loc, x, y, minMax, valueStep, func)
	SS_Globals[var] = CreateFrame("Slider", nil, SS_Globals[parent], "OptionsSliderTemplate", BackdropTemplateMixin and "BackdropTemplate")
	SS_Globals[var]:SetPoint(loc, x, y);
	SS_Globals[var]:SetWidth(width);
	SS_Globals[var]:SetHeight(height);
	SS_Globals[var]:SetOrientation('HORIZONTAL');
	SS_Globals[var]:SetMinMaxValues(unpack(minMax));
	SS_Globals[var]:SetValueStep(valueStep);
	SS_Globals[var]:SetObeyStepOnDrag(true);
	SS_Globals[var]:SetScript("OnValueChanged", loadstring(func));
	SS_Globals[var]:Show();
end
function SS_RegisterBox(var, parent, loc, x, y, locked, tooltip)
	SS_Globals.dungeonData[var] = CreateFrame("CheckButton", nil, SS_Globals[parent], "ChatConfigCheckButtonTemplate", BackdropTemplateMixin and "BackdropTemplate");
	SS_Globals.dungeonData[var]:SetPoint(loc, x, y);
	SS_Globals.dungeonData[var]:SetHitRectInsets(0, 0, 0, 0);
	if locked then
		SS_Globals.dungeonData[var]:SetAlpha(0.3);
		SS_Globals.dungeonData[var]:Disable();
		SS_Globals.dungeonData[var].tooltip = tooltip
		SS_Globals.dungeonData[var]:SetMotionScriptsWhileDisabled(true);
	end
end
function SS_RegisterFrame(frame, var, parent, width, height, loc, x, y, texture, template, tooltip)
	SS_Globals[var] = CreateFrame(frame, nil, SS_Globals[parent], template, BackdropTemplateMixin and "BackdropTemplate");
	SS_Globals[var]:SetPoint(loc, x, y);
	if width then
		SS_Globals[var]:SetWidth(width);
	end
	if height then
		SS_Globals[var]:SetHeight(height);
	end
	if texture then
		SS_Globals[var]:SetNormalTexture(texture)
	end
	if string.find(var, "Spacer") then
		SS_Globals[var]:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth() - 20);
		SS_Globals[var]:SetAlpha(0.5);
	elseif string.find(var, "Button") then
		SS_Globals[var]:SetHitRectInsets(0, 0, 0, 0);
		SS_Globals[var].tooltip = tooltip;
	end
end

function SS_interfaceConfig(update)
	for page, var in ipairs(SS_optionsTable2) do
		if page == 1 then
			SS_Globals[var.parent] = CreateFrame("Frame", var.frame, UIParent, BackdropTemplateMixin and "BackdropTemplate");
			SS_Globals[var.parent].okay = function(self) SS_datacall("update"); SS_UpdateChildFrame(); end;
		else
			SS_Globals[var.parent] = CreateFrame("Frame", var.frame, SS_Globals.main, BackdropTemplateMixin and "BackdropTemplate");
			SS_Globals[var.parent].parent = SS_Globals.main.name;
		end
		SS_Globals[var.parent].name = var.pname;
		SS_Globals[var.parent]:SetBackdrop(SS_optionsPanelBackdrop);
		SS_Globals[var.parent]:SetBackdropColor(0, 0, 0, 0.8);
		InterfaceOptions_AddCategory(SS_Globals[var.parent]);
		for i, tVar in pairs(var) do
			if string.find(i, "Text") then
				SS_RegisterText(i, var.parent, tVar.fontSize, tVar.loc, tVar.x, tVar.y, tVar.text)
			elseif string.find(i, "Spacer") then
				SS_RegisterFrame("Button", i, var.parent, nil, tVar.height, tVar.loc, tVar.x, tVar.y, tVar.texture)
			elseif string.find(i, "Button") then	
				SS_RegisterFrame("CheckButton", i, var.parent, nil, nil, tVar.loc, tVar.x, tVar.y, nil, "ChatConfigCheckButtonTemplate", tVar.tooltip)
			elseif string.find(i, "Slider") then
				SS_RegisterSlider(i, var.parent, tVar.width, tVar.height, tVar.loc, tVar.x, tVar.y, tVar.minMax, tVar.valueStep, tVar.func)
			elseif string.find(i, "Box") then	
				SS_RegisterBox(i, var.parent, tVar.loc, tVar.x, tVar.y, tVar.locked)
			elseif string.find(i, "BigIcon") then
				SS_RegisterFrame("Button", i, var.parent, tVar.width, tVar.height, tVar.loc, tVar.x, tVar.y, tVar.texture)
			elseif string.find(i, "InstanceTrigger") then
				local storedMap = "Random Dungeons";
				local ycoord = -155
				for k=1, #SS_sortedDungeonsID do
					local boxes = {-150,0,150}
					local nameVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].name, " ", ""))
					local mapVar = ("SS_" .. string.gsub(SS_sortedDungeonsID[k].mapName, " ", "") .. "HeaderText")
					local spacerVar = string.gsub(storedMap, " ", "");
					nameVar = string.gsub(nameVar, "'", "")
					if string.find(SS_sortedDungeonsID[k].name, "Heroic") and SS_sortedDungeonsID[k].mapName == "Random Dungeons" then
						SS_RegisterText(nameVar.."Text", var.parent, 14, "TOPLEFT", 10, -155, SS_sortedDungeonsID[k].name..":")
						for j = 1, 3 do
							SS_RegisterBox(nameVar.."Box"..j, var.parent, "TOP", boxes[j], -150, SS_sortedDungeonsID[k].locked, SS_sortedDungeonsID[k].tooltip)
						end
					else
						if not (SS_sortedDungeonsID[k].mapName == storedMap) then
							storedMap = SS_sortedDungeonsID[k].mapName;
							ycoord = ycoord - 20;
							SS_RegisterFrame("Button", spacerVar.."Spacer", var.parent, nil, tVar.height, tVar.loc, tVar.x, ycoord, tVar.texture)
							ycoord = ycoord - 5;
							SS_RegisterText(mapVar, var.parent, 14, "TOP", 0, ycoord, "|cffff0000"..SS_sortedDungeonsID[k].mapName.."|r")
						end
						ycoord = ycoord - 15;
						for j = 1, 3 do
							SS_RegisterBox(nameVar.."Box"..j, var.parent, "TOP", boxes[j], ycoord, SS_sortedDungeonsID[k].locked, SS_sortedDungeonsID[k].tooltip)
							if SS_sortedDungeonsID[k].locked and j == 3 then
								if SS_InstanceNewsTable[nameVar] then
									SS_RegisterText(nameVar.."LockedText", var.parent, 14, "TOPLEFT", 21, -4, SS_InstanceNewsTable[nameVar], SS_Globals.dungeonData[nameVar.."Box"..j]);
								else
									SS_RegisterText(nameVar.."LockedText", var.parent, 14, "TOPLEFT", 21, -4, SS_sortedDungeonsID[k].reason, SS_Globals.dungeonData[nameVar.."Box"..j])
								end
							end
						end
						ycoord = ycoord - 5;
						SS_RegisterText(nameVar.."Text", var.parent, 14, "TOPLEFT", 10, ycoord, SS_sortedDungeonsID[k].name..":")
					end
				end
			end
		end
	end
	SS_SetupCoreFrame();
end
