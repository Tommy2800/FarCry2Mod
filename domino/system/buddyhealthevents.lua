
-- DOMINO REFLECTION BOX START
--
-- <Display Category="Buddies" Text="BuddyHealthEvents"/>
--
-- <ControlIn  Name="Enable"/>
-- <ControlIn  Name="Disable"/>
-- <DataIn     Name="Buddy"        Type="Nomad|entity"/>
--
-- <ControlOut Name="TakesDamage"     Delayed="true"/>
-- <ControlOut Name="BuddyDown"       Delayed="true"/>
-- <ControlOut Name="BuddyDownDied"   Delayed="true"/>
-- <ControlOut Name="BuddyDownHealed" Delayed="true"/>
-- <DataOut    Name="Value"        Type="Core|float"/>
-- <DataOut    Name="Instigator"   Type="Nomad|entity"/>
-- <DataOut    Name="Reason"       Type="Core|string"/>
--
-- DOMINO REFLECTION BOX END

BuddyHealthEvents = {
};

function BuddyHealthEvents:Create(cbox)
	-- left empty on purpose
end

function BuddyHealthEvents:Init(cbox)
	self.HealthString = GetNoCaseStringID("health");

	self.callidCounterEvent = nil;
	self.callidBuddyDown = nil;
	self.callidBuddyDownDied = nil;
	self.callidBuddyDownHeal = nil;
end

function BuddyHealthEvents:ShutDown()
  self._type.UnregisterCallback(self);
end

function BuddyHealthEvents:Enable()
	if (self.Buddy ~= nil and self.callidCounterEvent == nil) then
		--System:Trace("Enabling health events for pawn "..self.Buddy);
		instance = CScriptCallbackSystem_GetInstance();
		self.callidCounterEvent = instance:RegisterEventCallback(self.Buddy, self, "Event_CounterEvent", "CCounterEvent");
		self.callidBuddyDown = instance:RegisterEventCallback(self.Buddy, self, "Event_BuddyDown", "BuddyDown_Start");
		self.callidBuddyDownDied = instance:RegisterEventCallback(self.Buddy, self, "Event_BuddyDownDied", "BuddyDown_Died");
		self.callidBuddyDownHeal = instance:RegisterEventCallback(self.Buddy, self, "Event_BuddyDownHeal", "BuddyDown_Healed");
	end
end

function BuddyHealthEvents:Disable()
  self._type.UnregisterCallback(self);
end

function BuddyHealthEvents:UnregisterCallback()
	if (self.Buddy ~= nil and self.callidCounterEvent ~= nil) then
		--System:Trace("Disabling health events for pawn "..self.Buddy);
		instance = CScriptCallbackSystem_GetInstance();
		instance:RemoveCallback(self.Buddy, self.callidCounterEvent);
		self.callidCounterEvent = nil;
		instance:RemoveCallback(self.Buddy, self.callidBuddyDown);
		self.callidBuddyDown = nil;
		instance:RemoveCallback(self.Buddy, self.callidBuddyDownDied);
		self.callidBuddyDownDied = nil;
		instance:RemoveCallback(self.Buddy, self.callidBuddyDownHeal);
		self.callidBuddyDownHeal = nil;
	end
end

function BuddyHealthEvents:Event_CounterEvent(counter, value, instigator, reason)
	-- Kill buddy if they die from a machete takedown
	if (tostring(reason) == "-1339130170") then
		System:Log("BuddyHealthEvents: Buddy killed by machete takedown!");
		GetBuddiesManager():MercyKilledBuddy(self.Buddy);
		return self:BuddyDownDied();
	end
	if (counter == self.HealthString) then
		self.Value = value;
		self.Instigator = instigator;
		self.Reason = reason;
		return self:TakesDamage();
	end
end

function BuddyHealthEvents:Event_BuddyDown()
	return self:BuddyDown();
end

function BuddyHealthEvents:Event_BuddyDownDied()
	--System:Trace("Pawn "..self.Buddy.." killed");
	return self:BuddyDownDied();
end

function BuddyHealthEvents:Event_BuddyDownHeal(entity)
	--System:Trace("Pawn "..self.Buddy.." healed");
	return self:BuddyDownHealed();
end

export = BuddyHealthEvents;
BuddyHealthEvents = nil;
