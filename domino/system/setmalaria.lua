
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Player Avatar" Text="SetMalaria"/>
--
-- <ControlIn  Name="StartMalariaBubbleMode"/>
-- <ControlIn  Name="StopMalariaBubbleMode"/>
-- <ControlIn  Name="SetLimitedPills"/>
-- <ControlIn  Name="SetNotSoLimitedPills"/>
-- <ControlIn  Name="SetUnlimitedPills"/>
-- <ControlIn  Name="SetSicknessLevel"/>
-- <ControlIn  Name="StopMalariaBlackout"/>
-- <ControlIn  Name="ForceMalariaBubbleBlackout"/>
-- <ControlIn  Name="ForceMalariaMinorAttack"/>
--
-- <DataIn     Name="Player"              Type="Nomad|entity"/>
-- <DataIn     Name="SicknessLevel"       Type="Core|int"/>
--
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

SetMalaria = {
};

function SetMalaria:Create(cbox)
	-- left empty on purpose
end

function SetMalaria:Init(cbox)
	-- left empty on purpose
end

function SetMalaria:ShutDown()
	-- left empty on purpose
end

function SetMalaria:StartMalariaBubbleMode()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_StartMalariaBubbleMode");
    return self:Out();
  end
end

function SetMalaria:StopMalariaBubbleMode()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_StopMalariaBubbleMode");
    return self:Out();
  end
end

function SetMalaria:SetLimitedPills()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_SetLimitedPills");
    return self:Out();
  end
end

function SetMalaria:SetNotSoLimitedPills()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_SetNotSoLimitedPills");
    return self:Out();
  end
end

function SetMalaria:SetUnlimitedPills()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_SetUnlimitedPills");
    return self:Out();
  end
end

function SetMalaria:SetSicknessLevel()
	if (self.SicknessLevel ~= nil) then
		-- Update 3.6: Optional malaria via external configuration file
		if (Globals.MASTER_GameGlobals.EnableMalaria == 1) then
			SetSicknessLevel(self.SicknessLevel);
		elseif (Globals.MASTER_GameGlobals.EnableMalaria == 0) then
			SetSicknessLevel(0);
		end
		return self:Out();
	end
end

function SetMalaria:StopMalariaBlackout()
	StopMalariaBlackout();
	return self:Out();
end

function SetMalaria:ForceMalariaBubbleBlackout()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_TriggerMalariaBubbleBlackout");
    return self:Out();
  end
end

function SetMalaria:ForceMalariaMinorAttack()
  if (self.Player ~= nil) then
    CDominoManager_GetInstance():SendRegisteredEventToEntity(self.Player, "CFCXCountersComponentPlayerSP_TriggerMinorMalariaAttack");
    return self:Out();
  end
end

export = SetMalaria;
SetMalaria = nil;
