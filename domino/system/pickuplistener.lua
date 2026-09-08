
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Entity" Text="PickupListener"/>
--
-- <ControlIn  Name="Enable"/>
-- <ControlIn  Name="Disable"/>
-- <DataIn     Name="Pickup"        Type="Nomad|entity"/>
--
-- <ControlOut Name="PickedUp"      Delayed="true"/>
--
-- DOMINO REFLECTION BOX END

PickupListener = {
};

function PickupListener:Create(cbox)
	-- left empty on purpose
end

function PickupListener:Init(cbox)
	self.callidPickup = nil;
end

function PickupListener:ShutDown()
  self._type.UnregisterCallback(self);
end

function PickupListener:Enable()
	if (self.Pickup ~= nil and self.callidPickup == nil) then
		instance = CScriptCallbackSystem_GetInstance();
		self.callidPickup = instance:RegisterEventCallback(self.Pickup, self, "Event_PickedUp", "DominoCallbackPickupPicked");
	end
end

function PickupListener:EnableDiamond()
	if (self.Pickup ~= nil and self.callidPickup == nil) then
		instance = CScriptCallbackSystem_GetInstance();
		self.callidPickup = instance:RegisterEventCallback(self.Pickup, self, "Event_PickedUpDiamond", "DominoCallbackPickupPicked");
	end
end

function PickupListener:Disable()
  self._type.UnregisterCallback(self);
end

function PickupListener:UnregisterCallback()
	if (self.Pickup ~= nil and self.callidPickup ~= nil) then
		instance = CScriptCallbackSystem_GetInstance();
		instance:RemoveCallback(self.Pickup, self.callidPickup);
		self.callidPickup = nil;
    end
end

function PickupListener:Event_PickedUp()
	self._type.UnregisterCallback(self);
	return self:PickedUp();
end

function PickupListener:Event_PickedUpDiamond()
	-- Return briefcase entity for diamond briefcase pickup listener
	self._type.UnregisterCallback(self);
	return self:PickedUp(self.Pickup);
end


export = PickupListener;
PickupListener = nil;
