PostFx = {
}

function PostFx:Create(cbox)
end

function PostFx:Init(cbox)
end

function PostFx:ShutDown()
end

function PostFx:Enable()
	if self.PostFxName ~= nil then
		if (self.PostFxName == "blackscreenfx") and (Globals.MASTER_GameGlobals.FinishedIntro ~= 0) then
			EnablePostFx(self.PostFxName);
		elseif (self.PostFxName ~= "blackscreenfx") or (Globals.MASTER_GameGlobals.FinishedIntro == 1) then
			EnablePostFx(self.PostFxName);
		end
		return self:Out();
	end
end

function PostFx:Disable()
	if self.PostFxName ~= nil then
		if (self.PostFxName == "blackscreenfx") and (Globals.MASTER_GameGlobals.FinishedIntro ~= 0) then
			DisablePostFx(self.PostFxName);
		elseif (self.PostFxName ~= "blackscreenfx") or (Globals.MASTER_GameGlobals.FinishedIntro == 1) then
			DisablePostFx(self.PostFxName);
		end
		return self:Out();
	end
end

export = PostFx;
PostFx = nil;