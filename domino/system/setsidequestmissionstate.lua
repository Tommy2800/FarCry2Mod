-- Update 3.5: This file has been made mostly redundant because the logic for "completing" BSQ missions has been moved to missioncompleted.lua

SidequestMissionState = {
}

function SidequestMissionState:Create(cbox)
	-- left empty on purpose
end

function SidequestMissionState:Init(cbox)
	-- left empty on purpose
end

function SidequestMissionState:ShutDown()
	-- left empty on purpose
end

function SidequestMissionState:Accepted()
	if (self.Buddy ~= nil) then
		--GetBuddiesManager():SetSidequestMissionState("Accepted", self.Buddy);
		return self:Out();
	end
end

function SidequestMissionState:Canceled()
	GetBuddiesManager():SetSidequestMissionState("Canceled", "");
	return self:Out();
end

function SidequestMissionState:Succeeded()
	--GetBuddiesManager():SetSidequestMissionState("Succeeded", "");
	return self:Out();
end

-- Export visible for Nomad engine.
export = SidequestMissionState;
SidequestMissionState = nil;
