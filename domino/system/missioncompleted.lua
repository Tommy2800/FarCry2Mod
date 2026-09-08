
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Missions" Text="MissionCompleted"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="Mission"      Type="Core|string"/>
--
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

MissionCompleted = {
}

function MissionCompleted:Create(cbox)
	-- left empty on purpose
end

function MissionCompleted:Init(cbox)
	-- left empty on purpose
end

function MissionCompleted:ShutDown()
	-- left empty on purpose
end

function MissionCompleted:In()
	if (self.Mission ~= nil) then
		-- Remove objective icons for buddy unlock/rescue missions
		if (self.Mission == "A1BU01") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055416665744608086", "CMapElementComponent_Disable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055958087396790125", "CMapElementComponent_Disable");
			-- Prevent the game from disabling faction "objective available" markers after completing buddy rescues
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A1BU01") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		elseif (self.Mission == "A1BU02") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055416731150584666", "CMapElementComponent_Disable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055958096414543729", "CMapElementComponent_Disable");
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A1BU02") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		elseif (self.Mission == "A1BU03") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055416776040123230", "CMapElementComponent_Disable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055958102999601013", "CMapElementComponent_Disable");
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A1BU03") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		elseif (self.Mission == "A1BU04") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055416805997939554", "CMapElementComponent_Disable");
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2055958108324269945", "CMapElementComponent_Disable");
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A1BU04") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		elseif (self.Mission == "A2BU06") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2053717871917269480", "CMapElementComponent_Disable");
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A2BU06") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		elseif (self.Mission == "A2BU07") then
			CDominoManager_GetInstance():SendRegisteredEventToEntity("2053718284374643584", "CMapElementComponent_Disable");
			if (Globals.MASTER_GameGlobals.AcceptedLibMissionID == "A2BU07") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 0;
			end
		-- FIX: Re-enable airport enemies after greenhouse library mission
		elseif (self.Mission == "A1LM05") then
			CGameMissionMgr_GetInstance():GetMission("Missions/_DisableForMission/W1D3_A15Airstrip_EnemiesSTP"):Enable();
		end

		-- Update 3.7: Fix SetHudMode getting stuck in Cinematic mode after certain missions (preventing the player from saving the game)
		if (self.Mission == "A1SM01") or (self.Mission == "A2SM08") then
			SetCinematicUIMode(1);
		end

		-- Give mission reward for buddy sidequests & show contextual "Mission Completed" UI messages
		found = strfind(self.Mission, "BSQ", 1, 1);
		found1 = strfind(self.Mission, "CV0", 1, 1);
		found2 = strfind(self.Mission, "AS0", 1, 1);
		if (found ~= nil) then
			-- MODIFIED: Only give reward and completion message if debriefing has been completed
			-- If the objective was just completed, wait for the player to return to the buddy for debriefing
			if (Globals.MASTER_GameGlobals.BSQ_MissionDebriefingStarted == 1) then
				CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "MikesPlace", "MISSION_CONCLUDED", -1, -1, 5);
				CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), "0x004f014b", 11, self, "DummyFunction");
				AddDiamonds(20);
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;

				-- Update 3.5: Add sidequest mission completed logic to fix an issue where buddy history would sometimes not update after completing a BSQ mission
				GetBuddiesManager():SetSidequestMissionState("Accepted", Globals.MASTER_GameGlobals.BSQBuddyName);
				GetBuddiesManager():SetSidequestMissionState("Succeeded", "");

				-- Update 3.5: Unlock golden AK-47 after completing BSQ missions
				Globals.MASTER_GameGlobals.BSQMissionsCompleted = Globals.MASTER_GameGlobals.BSQMissionsCompleted + 1;
				if (Globals.MASTER_GameGlobals.BSQMissionsCompleted == 10) then
					GetWeaponBazaar():UnlockItem("goldak47 crate");
					CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "WeaponShop", "GoldAKAvailable", -1, -1, 5);
				end
			else
				-- Objective just completed, player needs to return to buddy for debriefing
				-- Update objective marker to point back to the buddy
				CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "MikesPlace", "RETURN_TO_BUDDY", -1, -1, 5);
				-- Set flag to indicate the main objective is complete and debriefing is needed
				Globals.MASTER_GameGlobals.BSQ_MainObjectiveComplete = 1;
			end
		elseif (found1 ~= nil) then
			CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "WeaponShop", "MISSION_CONCLUDED", -1, -1, 5);
			CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), "0x004f014b", 11, self, "DummyFunction");
		elseif (found2 ~= nil) then
			CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "CellTower", "MISSION_CONCLUDED", -1, -1, 5);
			CDominoSoundManager_GetInstance():PlaySound(GetLocalPlayerId(), "0x004f014b", 11, self, "DummyFunction");
		end

		System:Log("MissionCompleted: "..self.Mission);
		GetFCXMissionManager():MissionCompleted(self.Mission);
		return self:Out();
	end
end

-- Export visible for Nomad engine.
export = MissionCompleted;
MissionCompleted = nil;
