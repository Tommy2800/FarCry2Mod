
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Missions" Text="GiveMissionReward"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="Mission"      Type="Core|string"/>
--
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

GiveMissionReward = {
}

function GiveMissionReward:Create(cbox)
	-- left empty on purpose
end

function GiveMissionReward:Init(cbox)
	-- left empty on purpose
end

function GiveMissionReward:ShutDown()
	-- left empty on purpose
end

function GiveMissionReward:In()
	if (self.Mission ~= nil) then
		-- MODIFIED: Check if this is a buddy sidequest that needs debriefing first
		found = strfind(self.Mission, "BSQ", 1, 1);
		
		-- Only give reward if:
		-- 1. It's NOT a buddy sidequest, OR
		-- 2. It IS a buddy sidequest AND debriefing has been started (player returned to buddy)
		if (found == nil) or (Globals.MASTER_GameGlobals.BSQ_MissionDebriefingStarted == 1) then
			GetFCXMissionManager():GiveMissionReward(self.Mission);

			-- Track diamonds obtained via mission rewards
			if (self.Mission == "ASSW1") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "ASSW2") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1SM02") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 25;
			elseif (self.Mission == "A2SM06") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 25;
			elseif (self.Mission == "A2SM08") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 40;
			elseif (self.Mission == "A3SM11") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 40;
			elseif (self.Mission == "A3SM12") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 30;
			elseif (self.Mission == "A3SM13") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 30;
			elseif (self.Mission == "A1LM01") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1LM02") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1LM03") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1LM04") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1LM05") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A1LM06") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 20;
			elseif (self.Mission == "A2LM07") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
			elseif (self.Mission == "A2LM08") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
			elseif (self.Mission == "A2LM09") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
			elseif (self.Mission == "A2LM10") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
			elseif (self.Mission == "A2LM11") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
			elseif (self.Mission == "A2LM12") then
				Globals.MASTER_GameGlobals.DiamondCounter = Globals.MASTER_GameGlobals.DiamondCounter + 35;
		--ZIFTEXT
			end
		else
			-- BSQ mission not debriefed yet, skip reward
			System:Log("GiveMissionReward: Skipping reward for BSQ mission " .. self.Mission .. " - debriefing not started yet");
		end

		return self:Out();
	end
end

-- Export visible for Nomad engine.
export = GiveMissionReward;
GiveMissionReward = nil;
