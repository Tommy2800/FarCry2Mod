
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Pawns" Text="PlayBark"/>
--
-- <ControlIn  Name="Start"/>
-- <DataIn     Name="PawnAgent"  Type="Nomad|entity"/>
-- <DataIn     Name="OtherAgent"  Type="Nomad|entity"/>
-- <DataIn     Name="Mission"    Type="Core|string"/>
-- <DataIn     Name="Block"      Type="Core|string"/>
--
-- <ControlOut Name="Started"    Delayed="true"/>
-- <ControlOut Name="Finished"   Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PlayBark = {
};

function PlayBark:Create(cbox)
	-- left empty on purpose
end

function PlayBark:Init(cbox)
	-- create a global value to retain callbacks
	if (Globals.PlayBark == nil) then
		--System:Trace("Creating the global for PlayBark");
		Globals.PlayBark = {};
	end
end

function PlayBark:ShutDown()
  if (self.PawnAgent and Globals.PlayBark[self.PawnAgent] ~= nil) then
		--System:Trace("PlayBark:Shutdown["..self.PawnAgent.."]");
    cbSyst = CScriptCallbackSystem_GetInstance(); 
		if (Globals.PlayBark[self.PawnAgent].callidSentBarkCommand ~= nil) then
			--System:Trace("Remove not yet sent command "..Globals.PlayBark[self.PawnAgent].callidSentBarkCommand);
			CDominoManager_GetInstance():RemoveCommandEventToEntity(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidSentBarkCommand);
			Globals.PlayBark[self.PawnAgent].callidSentBarkCommand = nil;
		end
    if (Globals.PlayBark[self.PawnAgent].callidStartedBark ~= nil) then
	    cbSyst:RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidStartedBark);
	    Globals.PlayBark[self.PawnAgent].callidStartedBark = nil;
	  end
	  if (Globals.PlayBark[self.PawnAgent].callidFinishedBark ~= nil) then
	    cbSyst:RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidFinishedBark);
	    Globals.PlayBark[self.PawnAgent].callidFinishedBark = nil;
	  end
	end
end

function PlayBark:Start()
	if (self.PawnAgent ~= nil and self.Mission ~= nil and self.Block ~= nil) then
		--System:Trace("PlayBark "..self.PawnAgent);
		if (Globals.PlayBark[self.PawnAgent] == nil) then
			--System:Trace("no bark info was found for this pawn "..self.PawnAgent);
			Globals.PlayBark[self.PawnAgent] = {};
		end
		if (Globals.PlayBark[self.PawnAgent].callidFinishedBark ~= nil) then
			--System:Trace("PlayBark - already a finished bark "..self.PawnAgent);
			CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidFinishedBark);
		end
		Globals.PlayBark[self.PawnAgent].callidFinishedBark = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_Finished", "PlayBarkFinished");
		if (Globals.PlayBark[self.PawnAgent].callidStartedBark ~= nil) then
			--System:Trace("PlayBark - already a started bark "..self.PawnAgent);
			CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidStartedBark);
		end
		Globals.PlayBark[self.PawnAgent].callidStartedBark = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_Started", "PlayBarkStarted");
		
		if(self.OtherAgent == nil) then
			self.OtherAgent = GetInvalidEntityId();
		end
		
		sent, Globals.PlayBark[self.PawnAgent].callidSentBarkCommand = CDominoManager_GetInstance():SendCommandEventToEntity2(self.PawnAgent, "PlayBark", self, "BarkCommandSent", self.Mission, self.Block, self.OtherAgent);
		if (sent == 1) then
			Globals.PlayBark[self.PawnAgent].callidSentBarkCommand = nil;
		end
		--System:Trace("Sent PlayBark event to "..self.PawnAgent);
	end
end

function PlayBark:BarkCommandSent()
	--System:Trace("Bark command sent to "..self.PawnAgent);
	Globals.PlayBark[self.PawnAgent].callidSentBarkCommand = nil;
end

function PlayBark:Event_Started()
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidStartedBark);
	Globals.PlayBark[self.PawnAgent].callidStartedBark = nil;
	SendSomeoneTalkedEventToPlayer();

	--System:Log("PlayBark: Pawn: "..tostring(self.PawnAgent));

	-- Fix: Don't allow the player to skip buddy sidequest dialogs. Door check is sufficient to determine whether the player is at Mike's or not.
	pawnName = GetEntityName(self.PawnAgent);
	--pawnChk = strfind(pawnName, "buddies.Buddies", 1, 1);
	pawnChk = nil -- Disable check, apparently there is no issue with this.
	if (pawnChk ~= nil) then
		if (GetEntityName("2055612104047625477") ~= "InteractiveDoors.Urbain02_AnimatedDoor01_2") and (GetEntityName("2057161077333971361") ~= "InteractiveDoors.Colonial_AnimatedDoor01_MikesPlace2") then
			pawnChk = nil
		end
	end

	if (self.PawnAgent ~= "2054703037638782554") and (self.PawnAgent ~= "2054702832585551444") and (self.PawnAgent ~= "2054371512330233159") and (pawnChk == nil) then
		-- Set up interaction listener for skipping
		self.callidPawnInteracted = CScriptCallbackSystem_GetInstance():RegisterEventCallback(self.PawnAgent, self, "Event_Finished", "Use");
		CDominoManager_GetInstance():SendCommandEventToEntity(self.PawnAgent, "SetUsability", "true", 1);
	end

	return self:Started();
end

function PlayBark:Event_Finished()
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, self.callidPawnInteracted);
	CDominoManager_GetInstance():SendCommandEventToEntity(self.PawnAgent, "SetUsability", "false", 1);
	CScriptCallbackSystem_GetInstance():RemoveCallback(self.PawnAgent, Globals.PlayBark[self.PawnAgent].callidFinishedBark);
	Globals.PlayBark[self.PawnAgent].callidFinishedBark = nil;
	SendSomeoneTalkedEventToPlayer();
	return self:Finished();
end


export = PlayBark;
PlayBark = nil;