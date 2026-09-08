
-- DOMINO REFLECTION BOX START
--
-- <Display Category="UI" Text="CustomPopUpTutorialMessageBox"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="PageId"   		  Type="Core|string"/>
-- <DataIn     Name="TitleLocId"   	Type="Core|string"/>
-- <DataIn     Name="TextLocId"     Type="Core|string"/>
-- <DataIn     Name="ButtonLocId"   Type="Core|string"/>
--
-- <ControlOut Name="Out"           Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

CustomPopUpTutorialMessageBox = {
};

function CustomPopUpTutorialMessageBox:Create(cbox)
	-- left empty on purpose
end

function CustomPopUpTutorialMessageBox:Init(cbox)
	self.PageId = "TO BE MODIFIED";
	self.TitleLocId = "TO BE MODIFIED";
	self.TextLocId = "TO BE MODIFIED";
	self.ButtonLocId = "";
end

function CustomPopUpTutorialMessageBox:ShutDown()
	-- left empty on purpose
end

function CustomPopUpTutorialMessageBox:In()
	-- System:Trace("CustomPopUpTutorialMessageBoxIn");
	--CGameMessageBoxHelper_GetInstance():CreateCustomTutorialMessageBox(self.PageId, self.TitleLocId, self.TextLocId, self.ButtonLocId, self, "Event_Continue");
	return self:Out();
end

function CustomPopUpTutorialMessageBox:Event_Continue()
	-- System:Trace("CustomPopUpTutorialMessageBoxEventContinue");
	return self:Out();
end

export = CustomPopUpTutorialMessageBox;
CustomPopUpTutorialMessageBox = nil;
