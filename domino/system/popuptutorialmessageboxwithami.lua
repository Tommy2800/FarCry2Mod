
-- DOMINO REFLECTION BOX START
--
-- <Display Category="UI" Text="PopUpTutorialMessageBoxWithAMI"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="TitleLocId"   	Type="Core|string"/>
-- <DataIn     Name="TextLocId"     Type="Core|string"/>
-- <DataIn     Name="ButtonLocId"   Type="Core|string"/>
-- <DataIn     Name="ActionMapId"   Type="Core|string"/>
--
-- <ControlOut Name="Out"           Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PopUpTutorialMessageBoxWithAMI = {
};

function PopUpTutorialMessageBoxWithAMI:Create(cbox)
	-- left empty on purpose
end

function PopUpTutorialMessageBoxWithAMI:Init(cbox)
	self.TitleLocId = "TO BE MODIFIED";
	self.TextLocId = "TO BE MODIFIED";
	self.ButtonLocId = "";
	self.ActionMapId = "";
end

function PopUpTutorialMessageBoxWithAMI:ShutDown()
	-- left empty on purpose
end

function PopUpTutorialMessageBoxWithAMI:In()
	-- System:Trace("PopUpTutorialMessageBoxWithAMIIn");
	--CGameMessageBoxHelper_GetInstance():CreateTutorialMessageBoxWithActionMap(self.TitleLocId, self.TextLocId, self.ButtonLocId, self.ActionMapId, self, "Event_Continue");
	return self:Out();
end

function PopUpTutorialMessageBoxWithAMI:Event_Continue()
	-- System:Trace("PopUpTutorialMessageBoxWithAMIEventContinue");
	return self:Out();
end

export = PopUpTutorialMessageBoxWithAMI;
PopUpTutorialMessageBoxWithAMI = nil;
