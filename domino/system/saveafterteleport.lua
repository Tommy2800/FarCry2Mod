
-- DOMINO REFLECTION BOX START
--
-- <Display Category="World" Text="SaveAfterTeleport"/>
--
-- <ControlIn  Name="In"/>
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

SaveAfterTeleport = {
};

function SaveAfterTeleport:Create(cbox)
	-- left empty on purpose
end

function SaveAfterTeleport:Init(cbox)
	-- left empty on purpose
end

function SaveAfterTeleport:ShutDown()
	-- left empty on purpose
end

function SaveAfterTeleport:In()
	local player = GetLocalPlayerId();
	--CDominoManager_GetInstance():SendRegisteredEventToEntity(player, "CPlayerSoundAndFXComponent_SaveAtNextUpdate");
	return self:Out();
end


export = SaveAfterTeleport;
SaveAfterTeleport = nil;
