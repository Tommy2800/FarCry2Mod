
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Entity" Text="GameElementObjective"/>
--
-- <ControlIn  Name="Enable"/>
-- <ControlIn  Name="Disable"/>
-- <ControlIn  Name="Available"/>
--
-- <DataIn     Name="GameElement"       Type="Nomad|entity"/>
--
-- <ControlOut Name="Out"/>
--
-- <Stateless/>
--
-- DOMINO REFLECTION BOX END

GameElementObjective = {
};

function GameElementObjective:Create(cbox)
	-- left empty on purpose
end

function GameElementObjective:Init(cbox)
	-- left empty on purpose
end

function GameElementObjective:ShutDown()
	-- left empty on purpose
end

function GameElementObjective:Enable()
	if (self.GameElement ~= nil) then
		CDominoManager_GetInstance():SendRegisteredEventToEntity(self.GameElement, "CMapElementComponent_Enable");
		return self:Out();
	end
end

function GameElementObjective:Disable()
	if (self.GameElement ~= nil) then
		CDominoManager_GetInstance():SendRegisteredEventToEntity(self.GameElement, "CMapElementComponent_Disable");
		return self:Out();
	end
end

function GameElementObjective:Available()
	-- Prevent re-activating arms merchant "mission available" icons if a convoy mission is already active
	if (self.GameElement == "2056078503794723290") or (self.GameElement == "2056079361659924512") or (self.GameElement == "2056099714163561456") or (self.GameElement == "2056084066859499705") or (self.GameElement == "2056068541666308064") or (self.GameElement == "2056178491822445886") or (self.GameElement == "2056525831972339862") or (self.GameElement == "2056770170667423783") or (self.GameElement == "2056093314630826866") or (self.GameElement == "2056757858518702518") then
		mission1 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_01");
		mission2 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_02");
		mission3 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_03");
		mission4 = CGameMissionMgr_GetInstance():GetMission("Missions/ConvoyMissions/Convoy_04");
		if (mission1:IsEnabled() == 1) or (mission2:IsEnabled() == 1) or (mission3:IsEnabled() == 1) or (mission4:IsEnabled() == 1) then
			self.GameElement = nil
			return self:Out();
		end
	end
	if (self.GameElement ~= nil) then
		CDominoManager_GetInstance():SendRegisteredEventToEntity(self.GameElement, "CMapElementComponent_Available");
		return self:Out();
	end
end

export = GameElementObjective;
GameElementObjective = nil;
