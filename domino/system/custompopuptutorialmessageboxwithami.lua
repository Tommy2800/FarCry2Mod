
-- DOMINO REFLECTION BOX START
--
-- <Display Category="UI" Text="CustomPopUpTutorialMessageBoxWithAMI"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="PageId"   		  Type="Core|string"/>
-- <DataIn     Name="TitleLocId"   	Type="Core|string"/>
-- <DataIn     Name="TextLocId"     Type="Core|string"/>
-- <DataIn     Name="ButtonLocId"   Type="Core|string"/>
-- <DataIn     Name="ActionMapId"   Type="Core|string"/>
--
-- <ControlOut Name="Out"           Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

CustomPopUpTutorialMessageBoxWithAMI = {
};

function CustomPopUpTutorialMessageBoxWithAMI:Create(cbox)
	-- left empty on purpose
end

function CustomPopUpTutorialMessageBoxWithAMI:Init(cbox)
	self.PageId = "TO BE MODIFIED";
	self.TitleLocId = "TO BE MODIFIED";
	self.TextLocId = "TO BE MODIFIED";
	self.ButtonLocId = "";
	self.ActionMapId = "";
end

function CustomPopUpTutorialMessageBoxWithAMI:ShutDown()
	-- left empty on purpose
end

function CustomPopUpTutorialMessageBoxWithAMI:In()
	-- System:Trace("CustomPopUpTutorialMessageBoxWithAMIIn");
	--CGameMessageBoxHelper_GetInstance():CreateCustomTutorialMessageBoxWithActionMap(self.PageId, self.TitleLocId, self.TextLocId, self.ButtonLocId, self.ActionMapId, self, "Event_Continue");
	return self:Out();
end

function CustomPopUpTutorialMessageBoxWithAMI:Event_Continue()
	-- System:Trace("CustomPopUpTutorialMessageBoxEventContinue");
	return self:Out();
end

export = CustomPopUpTutorialMessageBoxWithAMI;
CustomPopUpTutorialMessageBoxWithAMI = nil;
