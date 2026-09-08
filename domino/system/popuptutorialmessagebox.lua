
-- DOMINO REFLECTION BOX START
--
-- <Display Category="UI" Text="PopUpTutorialMessageBox"/>
--
-- <ControlIn  Name="In"/>
-- <DataIn     Name="TitleLocId"   	Type="Core|string"/>
-- <DataIn     Name="TextLocId"     Type="Core|string"/>
-- <DataIn     Name="ButtonLocId"   Type="Core|string"/>
--
-- <ControlOut Name="Out"           Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PopUpTutorialMessageBox = {
};

function PopUpTutorialMessageBox:Create(cbox)
	-- left empty on purpose
end

function PopUpTutorialMessageBox:Init(cbox)
	self.TitleLocId = "TO BE MODIFIED";
	self.TextLocId = "TO BE MODIFIED";
	self.ButtonLocId = "";
end

function PopUpTutorialMessageBox:ShutDown()
	-- left empty on purpose
end

function PopUpTutorialMessageBox:In()
	-- System:Trace("PopUpTutorialMessageBoxIn");
	--CGameMessageBoxHelper_GetInstance():CreateTutorialMessageBox(self.TitleLocId, self.TextLocId, self.ButtonLocId, self, "Event_Continue");
	return self:Out();
end

function PopUpTutorialMessageBox:Event_Continue()
	-- System:Trace("PopUpTutorialMessageBoxEventContinue");
	return self:Out();
end

export = PopUpTutorialMessageBox;
PopUpTutorialMessageBox = nil;
