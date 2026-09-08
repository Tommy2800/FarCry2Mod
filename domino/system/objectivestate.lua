ObjectiveState = {
}

function ObjectiveState:Create(cbox)
end

function ObjectiveState:Init(cbox)
end

function ObjectiveState:ShutDown()
end

function ObjectiveState:Set()
	-- Save the objective state for buddy side missions
	bsqcmp1 = strfind(self.ObjectiveState, "BSQ", 1, 1);
	bsqcmp2 = strfind(self.ObjectiveState, "_02", 1, 1);
	bsqcmp3 = strfind(self.ObjectiveState, "_03", 1, 1);
	bsqcmp4 = strfind(self.ObjectiveState, "_04", 1, 1);
	if (bsqcmp1 ~= nil) then
		if (bsqcmp2 ~= nil) then
			Globals.MASTER_GameGlobals.BSQObjectiveState = 2;
		elseif (bsqcmp3 ~= nil) then
			Globals.MASTER_GameGlobals.BSQObjectiveState = 3;
		elseif (bsqcmp4 ~= nil) then
			Globals.MASTER_GameGlobals.BSQObjectiveState = 4;
		else
			Globals.MASTER_GameGlobals.BSQObjectiveState = 0;
		end
	end

	-- Assassinations
	if (self.ObjectiveState == "A1AS02_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054317453334294078", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1AS06_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054311484852279984", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1AS03_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054343380973919289", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1AS05_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054310022480928796", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1AS04_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056828409868222433", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1AS01_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054317444568198717", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS01_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054328462587466933", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS02_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054313826043568636", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS03_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830252811841612", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS06_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330858573144450", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS05_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330896992969102", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2AS04_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330933196104091", "CMapElementComponent_Enable");

	-- Convoys
	elseif (self.ObjectiveState == "A1CV01_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825592298383672", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1CV02_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056824790001418097", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1CV04_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054355911494868108", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A1CV03_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055761005994071160", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2CV05_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054342307496340489", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2CV08_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054316367588367570", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2CV06_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2054631341630168541", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "A2CV07_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826553047755118", "CMapElementComponent_Enable");

	-- Buddy Sidequests
	elseif (self.ObjectiveState == "BSQ23_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826540697626986", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ24_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826512329451874", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ19_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620584811594009", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ18_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620541666885911", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ22_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830303688749136", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ26_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626311091421651", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ25_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626537122464226", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ14_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057337504385765261", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ21_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057424287087723342", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ20_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053622553877941124", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ24_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826512329451874", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055512443483866192", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ23_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826540697626986", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055512438039659596", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ18_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620541666885911", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488328087635786", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ22_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830303688749136", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055499009279148930", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ17_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053858342494798379", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488300537349958", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ16_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830074797184938", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488268083922750", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ20_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053622553877941124", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488339139626834", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ14_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057337504385765261", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488373314815842", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ26_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626311091421651", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488361526724446", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ19_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620584811594009", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488333347293006", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ25_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626537122464226", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488355891677018", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ21_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057424287087723342", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488352139872086", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ17_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2053858342494798379", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ16_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830074797184938", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ06_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487847720309386", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ07_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487853848187534", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ02_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825525887871280", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215270459585259", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ07_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487853848187534", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273565467403", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ13_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487979947855080", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215491941905219", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ12_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487962543590626", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290388820771", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ03_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825394931214632", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215272040837883", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ11_04") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487790000392175", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290390917931", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ01_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825379846400292", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215236844335843", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ08_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056842333445451858", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273563370243", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ15_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487998386015470", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215491946099531", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ06_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487847720309386", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273569661715", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ09_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056841984416444572", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290397209403", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ10_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487747891677139", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290393015091", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ04_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056824825340526453", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215272034546419", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ05_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056827751171647407", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273573856027", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ08_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056842333445451858", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ09_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056841984416444572", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ05_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056827751171647407", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ04_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056824825340526453", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ01_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825379846400292", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ03_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825394931214632", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ02_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825525887871280", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ12_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487962543590626", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ15_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487998386015470", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ13_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487979947855080", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ10_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487747891677139", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ11_03") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487890420418575", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487790000392175", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ11_01") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487780865198057", "CMapElementComponent_Enable");
	--	CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487878831556617", "CMapElementComponent_Enable");
	elseif (self.ObjectiveState == "BSQ11_02") then
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487780865198057", "CMapElementComponent_Disable");
	--	CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487878831556617", "CMapElementComponent_Disable");
		CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487890420418575", "CMapElementComponent_Enable");

	-- Mission Completed (faked to prevent resetting primary mission objective markers, if a primary mission isn't active the real SetObjectiveState will trigger - generic "Mission Completed" messages have been replaced by contextual ones in MissionCompleted.lua)
	elseif (self.ObjectiveState == "A1LM00_00") and (Globals.MASTER_GameGlobals.PrimaryMissionActive == 1) then
		System:Log("ObjectiveState: FakeMissionCompleted");
		CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), "0x004f014b", 11, self, "DummyFunction");
		CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "Added", "MISSION_CONCLUDED", -1, -1, 5);
	elseif (self.ObjectiveState == "A2LM00_00") and (Globals.MASTER_GameGlobals.PrimaryMissionActive == 1) then
		System:Log("ObjectiveState: FakeMissionCompleted");
		CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), "0x004f014b", 11, self, "DummyFunction");
		CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "Added", "MISSION_CONCLUDED", -1, -1, 5);

	else
		System:Log("Set self.ObjectiveState: "..tostring(self.ObjectiveState));
		SetObjectiveState(self.ObjectiveState or "", self.ShowPopup or 1);

		-- SetObjectiveState resets all map markers so re-enable side mission map markers if the missions are active
		-- Assassinations
		mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_02");
		mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_06");
		mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_03");
		mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_05");
		mission5 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_04");
		mission6 = CGameMissionMgr_GetInstance():GetMission("Missions/AssassinationMissions/Target_01");
		if (mission1:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054317453334294078", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054313826043568636", "CMapElementComponent_Enable");
		elseif (mission2:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054311484852279984", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330858573144450", "CMapElementComponent_Enable");
		elseif (mission3:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054343380973919289", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830252811841612", "CMapElementComponent_Enable");
		elseif (mission4:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054310022480928796", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330896992969102", "CMapElementComponent_Enable");
		elseif (mission5:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2056828409868222433", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054330933196104091", "CMapElementComponent_Enable");
		elseif (mission6:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054317444568198717", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054328462587466933", "CMapElementComponent_Enable");
		end

		-- Convoys
		mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_01");
		mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_02");
		mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_03");
		mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_04");
		if (mission1:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825592298383672", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054342307496340489", "CMapElementComponent_Enable");
		elseif (mission2:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2056824790001418097", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054631341630168541", "CMapElementComponent_Enable");
		elseif (mission3:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055761005994071160", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826553047755118", "CMapElementComponent_Enable");
		elseif (mission4:IsEnabled() == 1) then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054355911494868108", "CMapElementComponent_Enable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2054316367588367570", "CMapElementComponent_Enable");
		end

		-- Buddy Sidequests
		mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ01");
		mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ02");
		mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ03");
		mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ04");
		mission5 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ05");
		mission6 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ06");
		mission7 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ07");
		mission8 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ08");
		mission9 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ09");
		mission10 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ10");
		mission11 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ11");
		mission12 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ12");
		mission13 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ13");
		mission14 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ14");
		mission15 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ15");
		mission16 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ16");
		mission17 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ17");
		mission18 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ18");
		mission19 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ19");
		mission20 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ20");
		mission21 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ21");
		mission22 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ22");
		mission23 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ23");
		mission24 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ24");
		mission25 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ25");
		mission26 = CGameMissionMgr_GetInstance():GetMission("Missions/BuddySideQuests/BSQ26");
		-- World1 BSQ
		-- if (mission1 ~= nil) then
			-- if (mission1:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215236844335843", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825379846400292", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission2:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215270459585259", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825525887871280", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission3:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215272040837883", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056825394931214632", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission4:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215272034546419", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056824825340526453", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission5:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273573856027", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056827751171647407", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission6:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273569661715", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487847720309386", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission7:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273565467403", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487853848187534", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission8:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215273563370243", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056842333445451858", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission9:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290397209403", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056841984416444572", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission10:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290393015091", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487747891677139", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission11:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487890420418575", "CMapElementComponent_Enable");
				-- elseif (Globals.MASTER_GameGlobals.BSQObjectiveState == 3) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487790000392175", "CMapElementComponent_Enable");
				-- elseif (Globals.MASTER_GameGlobals.BSQObjectiveState == 4) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290390917931", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487780865198057", "CMapElementComponent_Enable");
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487878831556617", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission12:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215290388820771", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487962543590626", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission13:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215491941905219", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487979947855080", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission15:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057215491946099531", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055487998386015470", "CMapElementComponent_Enable");
				-- end
			-- Reset the last buddy mission ID since none are active
			-- else
				-- Globals.MASTER_GameGlobals.AcceptedBuddyMissionID = "x";
			-- end
		-- end
		-- World2 BSQ
		-- if (mission14 ~= nil) then
			-- if (mission14:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488373314815842", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057337504385765261", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission16:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488268083922750", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830074797184938", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission17:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488300537349958", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053858342494798379", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission18:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488328087635786", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620541666885911", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission19:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488333347293006", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053620584811594009", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission20:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488339139626834", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053622553877941124", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission21:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488352139872086", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2057424287087723342", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission22:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055499009279148930", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056830303688749136", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission23:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055512438039659596", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826540697626986", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission24:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055512443483866192", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2056826512329451874", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission25:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488355891677018", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626537122464226", "CMapElementComponent_Enable");
				-- end
			-- elseif (mission26:IsEnabled() == 1) then
				-- if (Globals.MASTER_GameGlobals.BSQObjectiveState == 2) then
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2055488361526724446", "CMapElementComponent_Enable");
				-- else
					-- CDominoManager_GetInstance():SendRegisteredEventToEntity("2053626311091421651", "CMapElementComponent_Enable");
				-- end
			-- Reset the last buddy mission ID since none are active
			-- else
				-- Globals.MASTER_GameGlobals.AcceptedBuddyMissionID = "x";
			-- end
		-- end
	end
	return self:Out();
end
export = ObjectiveState;
ObjectiveState = nil;