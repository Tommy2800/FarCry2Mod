
-- DOMINO REFLECTION BOX START
--
-- <Display Category="World" Text="OverrideEnvironmentFog"/>
--
-- <ControlIn  Name="SetOverride"/>
-- <ControlIn  Name="RemoveOverride"/>
-- <DataIn     Name="FogSetting"     			Type="Core|string"/>
-- <DataIn     Name="TransitionDuration"  Type="Core|float"/>
--
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

OverrideEnvironmentFog = {
}

function OverrideEnvironmentFog:Create(cbox)
	-- left empty on purpose
end

function OverrideEnvironmentFog:Init(cbox)
	-- left empty on purpose
end

function OverrideEnvironmentFog:ShutDown()
	-- left empty on purpose
end

function OverrideEnvironmentFog:SetOverride()
	if (self.TransitionDuration == nil) then
		self.TransitionDuration = 0;
	end
	if (self.FogSetting ~= nil) then
		CDynamicEnvironmentManager_GetInstance():SetFogOverride(self.FogSetting, self.TransitionDuration);
		Globals.MASTER_GameGlobals.FogOverride = self.FogSetting;
		return self:Out();
	end
end

function OverrideEnvironmentFog:RemoveOverride()
	if (self.TransitionDuration == nil) then
		self.TransitionDuration = 0;
	end
	if (self.FogSetting ~= nil) then
		CDynamicEnvironmentManager_GetInstance():RemoveFogOverride(self.FogSetting, self.TransitionDuration);
		Globals.MASTER_GameGlobals.FogOverride = "";
		return self:Out();
	end
end

-- Export visible for Nomad engine.
export = OverrideEnvironmentFog;
OverrideEnvironmentFog = nil;
