
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
			-- MODIFIED: For buddy sidequests, only give reward during debriefing, not when objective completes
			-- Mark that the main objective is complete and player must return to buddy
			Globals.MASTER_GameGlobals.BSQ_MainObjectiveComplete = 1;
			Globals.MASTER_GameGlobals.BSQ_MissionDebriefingStarted = 0;
			
			-- Show objective to return to buddy instead of mission concluded
			CFCXObjectiveHudManager_GetInstance():PushNewObjective("Mission", "MikesPlace", "RETURN_TO_BUDDY", -1, -1, 5);
			System:Log("BSQ Objective Complete: Player must return to buddy for debriefing - " .. self.Mission);
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
