SetMissionState = {
}

function SetMissionState:Create(cbox)
end

function SetMissionState:Init(cbox)
end

function SetMissionState:ShutDown()
end

function SetMissionState:Disable()
	if (self.Mission ~= nil) then
		if (self.Mission == "") then
			System:Log("Unable to disable layer - empty parameter for Mission");
			System:Trace("Unable to disable layer - empty parameter for Mission");
		else
			mission = CGameMissionMgr_GetInstance():GetMission(self.Mission);
			if (mission ~= nil) then
				System:Log("Disabled layer: "..self.Mission);
				mission:Disable();
			else
				System:Log("Unable to disable layer "..self.Mission);
				System:Trace("Unable to disable layer "..self.Mission);
			end
		end
	end
	return self:Out();
end

function SetMissionState:Enable()
	if (self.Mission ~= nil) then
		if (self.Mission == "") then
			System:Log("Unable to enable layer - empty parameter for Mission");
			System:Trace("Unable to enable layer  - empty parameter for Mission");
		else
			mission = CGameMissionMgr_GetInstance():GetMission(self.Mission);

			-- Prevent re-activating arms merchant if a convoy mission is already active
			if (self.Mission == "Missions/ConvoyMissions/ArmsMerchant") then
				mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_01");
				mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_02");
				mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_03");
				mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_04");
				if (mission1:IsEnabled() == 1) or (mission2:IsEnabled() == 1) or (mission3:IsEnabled() == 1) or (mission4:IsEnabled() == 1) then
					mission = nil
				end
			end

			-- Manually set primary mission variable because these missions are automatically triggered rather than accepted
			if (self.Mission == "Missions/StoryMissions/A3SM14/MisnBase_Airport")
			or (self.Mission == "Missions/StoryMissions/A1SM03/A1SM03_Journalist")
			or (self.Mission == "Missions/StoryMissions/A3SM15/A3SM15_Default")
			or (self.Mission == "Missions/StoryMissions/A2SM05/A2SM05")
			or (self.Mission == "Missions/StoryMissions/A3SM13/A3SM13_Reuben")
			then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 1;
			elseif (self.Mission == "Missions/StoryMissions/A3SM11/A3SM11_RedWarlord") or (self.Mission == "Missions/StoryMissions/A3SM11/A3SM11_BlueWarlord") then
				Globals.MASTER_GameGlobals.PrimaryMissionActive = 1;
				-- Disable old story mission layers (for some reason they are still enabled at this point in the story)
				disablemission1 = CGameMissionMgr_GetInstance():GetMission("Missions/StoryMissions/A2SM06/A2SM06_RedLieutenant");
				disablemission2 = CGameMissionMgr_GetInstance():GetMission("Missions/StoryMissions/A2SM06/A2SM06_BlueLieutenant");
				disablemission1:Disable();
				disablemission2:Disable();
			end

			-- Update 3.4: Don't allow enabling certain ghost patrols while convoy missions are active
			mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_01");
			mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_02");
			mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_03");
			mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_04");
			if (mission1:IsEnabled() == 1) then
				gpf1_1 = strfind(self.Mission, "2056468913989884390", 1, 1);
				gpf1_2 = strfind(self.Mission, "2057546522907661293", 1, 1);
				gpf1_3 = strfind(self.Mission, "2056662978259874372", 1, 1);
				if (gpf1_1 ~= nil) or (gpf1_2 ~= nil) or (gpf1_3 ~= nil) then
					mission = nil;
				end
			elseif (mission2:IsEnabled() == 1) then
				gpf1_1 = strfind(self.Mission, "2056438192392897874", 1, 1);
				gpf1_2 = strfind(self.Mission, "2057133873738840697", 1, 1);
				gpf1_3 = strfind(self.Mission, "2057144513377338494", 1, 1);
				gpf1_4 = strfind(self.Mission, "2056427141129582236", 1, 1);
				gpf1_5 = strfind(self.Mission, "2056427207743518368", 1, 1);
				gpf1_6 = strfind(self.Mission, "2056427363509483172", 1, 1);
				gpf1_7 = strfind(self.Mission, "2057352088398087534", 1, 1);
				if (gpf1_1 ~= nil) or (gpf1_2 ~= nil) or (gpf1_3 ~= nil) or (gpf1_4 ~= nil) or (gpf1_5 ~= nil) or (gpf1_6 ~= nil) or (gpf1_7 ~= nil) then
					mission = nil;
				end
			elseif (mission3:IsEnabled() == 1) then
				gpf1_1 = strfind(self.Mission, "2056812158823434058", 1, 1);
				gpf1_2 = strfind(self.Mission, "2056812153247106886", 1, 1);
				gpf1_3 = strfind(self.Mission, "2056812163458139982", 1, 1);
				gpf1_4 = strfind(self.Mission, "2058404741829887257", 1, 1);
				gpf1_5 = strfind(self.Mission, "2057133115198974971", 1, 1);
				if (gpf1_1 ~= nil) or (gpf1_2 ~= nil) or (gpf1_3 ~= nil) or (gpf1_4 ~= nil) or (gpf1_5 ~= nil) then
					mission = nil;
				end
			elseif (mission4:IsEnabled() == 1) then
				gpf1_1 = strfind(self.Mission, "2056743406905876782", 1, 1);
				gpf1_2 = strfind(self.Mission, "2057143929180021134", 1, 1);
				if (gpf1_1 ~= nil) or (gpf1_2 ~= nil) then
					mission = nil;
				end
			end
				

			-- Don't enable ghost patrols while the intro sequence is running
			gpfound = strfind(self.Mission, "GhostPatrol", 1, 1);
			if (Globals.MASTER_GameGlobals.FinishedIntro == 0) and (gpfound ~= nil) then
				mission = nil;
			end

			if (mission ~= nil) then
				--System:Log("Enabled layer: "..self.Mission);
				mission:Enable();

				-- Update 3.4: Disable specific ghost patrols after activating any convoy mission
				concheck = strfind(self.Mission, "Missions/ConvoyMissions/Convoy_", 1, 1);
				if (concheck ~= nil) then
					self:DisableConvoyPatrols()
				end
			else
				System:Log("Unable to enable layer "..self.Mission);
				System:Trace("Unable to enable layer "..self.Mission);
			end
		end
	end
	return self:Out();
end

function SetMissionState:Off()
	if (self.Mission ~= nil) then
		if (self.Mission == "") then
			System:Log("Unable to turn off layer - empty parameter for Mission");
			System:Trace("Unable to turn off layer - empty parameter for Mission");
		else
			mission = CGameMissionMgr_GetInstance():GetMission(self.Mission);
			-- Prevent cancelling buddy missions when starting another mission
			found = strfind(self.Mission, "BuddySideQuests", 1, 1);
			-- Allow cancellation of buddy missions when the last story mission of world1 (killing APR or UFLL leader) is accepted. This is necessary to prevent a buddy sidequest from world1 being active while entering world2, which will cause world2's buddy sidequests to never activate.
			if (found ~= nil) and (Globals.MASTER_GameGlobals.AcceptedMissionID == "A1SM02") then
				Globals.MASTER_GameGlobals.AcceptedBuddyMissionID = "x";
				found = nil
			end
			if (mission ~= nil) and (found == nil) then
				System:Log("Off layer: "..self.Mission);
				mission:Off();
			else
				System:Log("Unable to turn off layer "..self.Mission);
				System:Trace("Unable to turn off layer "..self.Mission);
			end
		end
	end
	-- Only return Out if we are turning off a mission that isn't buddy related. This prevents buddy missions from cancelling themselves when another mission is started.
	if (found == nil) then
		return self:Out();
	end
end

function SetMissionState:DisableConvoyPatrols()
	-- Update 3.4: Check active convoy missions and disable the patrols along their paths

	worldChk = CGameMissionMgr_GetInstance():GetMission("Missions/StoryMissions/A1SM01/A1SM01_StreetFighting");
	if (worldChk ~= nil) then
		worldType = 1;
	else
		worldType = 2;
	end

	mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_01");
	mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_02");
	mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_03");
	mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_04");

	if (mission1:IsEnabled() == 1) then
		if (worldType == 1) then
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056468913989884390/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057546522907661293/RedPatrol9");
			dgp:Disable();
		else
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056662978259874372/RedPatrol9");
			dgp:Disable();
		end
	elseif (mission2:IsEnabled() == 1) then
		if (worldType == 1) then
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056438192392897874/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133873738840697/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057144513377338494/RedPatrol9");
			dgp:Disable();
		else
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427141129582236/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427207743518368/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056427363509483172/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057352088398087534/RedPatrol9");
			dgp:Disable();
		end
	elseif (mission3:IsEnabled() == 1) then
		if (worldType == 1) then
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812158823434058/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812153247106886/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056812163458139982/RedPatrol9");
			dgp:Disable();
		else
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057133115198974971/RedPatrol9");
			dgp:Disable();
		end
	elseif (mission4:IsEnabled() == 1) then
		if (worldType == 2) then
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2056743406905876782/RedPatrol9");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol0");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/BluePatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol1");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol2");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol3");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol4");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol5");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol6");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol7");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol8");
			dgp:Disable();
			dgp = CGameMissionMgr_GetInstance():GetMission("Missions/GhostPatrols/2057143929180021134/RedPatrol9");
			dgp:Disable();
		end
	end
	System:Log("SetMissionState: Finished checking and disabling patrols for convoy missions!");
end

export = SetMissionState;
SetMissionState = nil;
