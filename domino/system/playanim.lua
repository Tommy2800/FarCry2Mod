
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Pawns" Text="PlayAnim"/>
--
-- <ControlIn  Name="StartAnim"/>
-- <DataIn     Name="PawnAgent"     Type="Nomad|entity"/>
-- <DataIn     Name="LoopAnim"      Type="Core|bool"/>
-- <DataIn     Name="AnimFile"      Type="Nomad|animation"/>
--
-- <ControlOut Name="Started"       Delayed="true"/>
-- <ControlOut Name="Finished"      Delayed="true"/>
-- <ControlOut Name="RealFinish"      Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PlayAnim = {
};

function PlayAnim:Create(cbox)
	-- left empty on purpose
end

function PlayAnim:Init(cbox)
	-- create a global value to retain callbacks
	if (Globals.PlayAnim == nil) then
		--System:Trace("Creating the global for PlayAnim");
		Globals.PlayAnim = {};
	end
end

function PlayAnim:ShutDown()
  if (self.PawnAgent and Globals.PlayAnim[self.PawnAgent] ~= nil) then
		--System:Trace("PlayAnim:Shutdown["..self.PawnAgent.."]");
    cbSyst = CScriptCallbackSystem_GetInstance(); 
		if (Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand ~= nil) then
			--System:Trace("Remove not yet sent command "..Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand);
			CDominoManager_GetInstance():RemoveCommandEventToEntity(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand);
			Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand = nil;
		end
    if (Globals.PlayAnim[self.PawnAgent].callidStartedAnim ~= nil) then
	    cbSyst:RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidStartedAnim);
	    Globals.PlayAnim[self.PawnAgent].callidStartedAnim = nil;
	  end
	  if (Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim ~= nil) then
	    cbSyst:RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim);
	    Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim = nil;
	  end
	  if (Globals.PlayAnim[self.PawnAgent].callidFinishedAnim ~= nil) then
	    cbSyst:RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishedAnim);
	    Globals.PlayAnim[self.PawnAgent].callidFinishedAnim = nil;
	  end
	end
end

function PlayAnim:StartAnim()
	if (self.PawnAgent ~= nil) then
		if (self.AnimFile ~= nil) then
			--System:Trace("PlayAnim "..self.PawnAgent);
			if (Globals.PlayAnim[self.PawnAgent] == nil) then
				--System:Trace("no anim info was found for this pawn "..self.PawnAgent);
				Globals.PlayAnim[self.PawnAgent] = {};
			end
			if (Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim ~= nil) then
				--System:Trace("PlayAnim - already a FinishingSoon anim "..self.PawnAgent);
				CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim);
			end
			Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_FinishingSoon", "FinishingSoonPlayAnim");
			
			if (Globals.PlayAnim[self.PawnAgent].callidStartedAnim ~= nil) then
				--System:Trace("PlayAnim - already a started anim "..self.PawnAgent);
				CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidStartedAnim);
			end
			Globals.PlayAnim[self.PawnAgent].callidStartedAnim = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_Started", "DominoAnimStarted");
			
			if(self.LoopAnim == nil) then
  	 	 	    self.LoopAnim = 0;
  	 	 	end
			
			sent, Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand = CDominoManager_GetInstance():SendCommandEventToEntity2(self.PawnAgent, "PlayAnim", self, "AnimCommandSent", self.AnimFile, self.LoopAnim, 1 );
			if (sent == 1) then
				Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand = nil;
			end
			--System:Trace("Sent PlayAnim event to "..self.PawnAgent.." with "..self.AnimFile);
		else
			System:Log("PlayAnim: ERROR!!  AnimFile is nil! Started & FinishingSoon will not output for this box!  Entity id "..self.PawnAgent);
			System:Log("PlayAnim cont'd: Fix your script! Check for badly placed interrupts, or boxes being called out of order.  Entity id "..self.PawnAgent);
		end
	else
		System:Log("PlayAnim: ERROR!! PawnAgent is nil!");
	end
end

function PlayAnim:AnimCommandSent()
	--System:Trace("Anim command sent to "..self.PawnAgent);
	Globals.PlayAnim[self.PawnAgent].callidSentAnimCommand = nil;
end

function PlayAnim:Event_Started()
	--System:Trace("Received PlayAnim Started event from "..self.PawnAgent.." with "..self.AnimFile);
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidStartedAnim);
	Globals.PlayAnim[self.PawnAgent].callidStartedAnim = nil;

	--Register for the Finished
	if (Globals.PlayAnim[self.PawnAgent].callidFinishedAnim ~= nil) then
		--System:Trace("PlayAnim - already a FinishingSoon anim "..self.PawnAgent);
		CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishedAnim);
	end
	Globals.PlayAnim[self.PawnAgent].callidFinishedAnim = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_Finished", "FinishedPlayAnim");

	-- Set up interaction listener for skipping
	found = strfind(self.AnimFile, "sm05_se01", 1, 1);
	found1 = strfind(self.AnimFile, "SM16_SE01", 1, 1);
	found2 = strfind(self.AnimFile, "cine_", 1, 1);
	found3 = strfind(self.AnimFile, "base_Guard", 1, 1);
	if (self.LoopAnim ~= 1) and (found == nil) and (found1 == nil) and (found2 == nil) and (found3 == nil) then
		System:Log("PlayAnim: Waiting for pawn interaction to skip "..self.AnimFile);
		self.callidPawnInteracted = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_FinishingSoon", "Use");
		CDominoManager_GetInstance():SendCommandEventToEntity(self.PawnAgent, "SetUsability", "true", 1);
	end

	return self:Started();
end

function PlayAnim:Event_FinishingSoon()
	CDominoManager_GetInstance():SendCommandEventToEntity(self.PawnAgent, "SetUsability", "false", 1);
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, self.callidPawnInteracted);
	--System:Trace("Received PlayAnim Finished event from "..self.PawnAgent.." with "..self.AnimFile);
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim);
	Globals.PlayAnim[self.PawnAgent].callidFinishingSoonAnim = nil;
	return self:Finished(); -- This is confusing, we should rename the out from RealFinish to Finished
end

function PlayAnim:Event_Finished()
	--System:Trace("Received PlayAnim Finished event from "..self.PawnAgent.." with "..self.AnimFile);
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayAnim[self.PawnAgent].callidFinishedAnim);
	Globals.PlayAnim[self.PawnAgent].callidFinishedAnim = nil;
	return self:RealFinish();
end


export = PlayAnim;
PlayAnim = nil;