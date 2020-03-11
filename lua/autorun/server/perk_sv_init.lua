resource.AddSingleFile("resource/fonts/ITCAvantGardePro-XLt.otf")
resource.AddSingleFile("resource/fonts/ITCAvantGardePro-Lt.otf")
resource.AddSingleFile("resource/fonts/ITCAvantGardePro-Md.otf")
resource.AddSingleFile("resource/fonts/ITCAvantGardePro-Demi.otf")

/*
	Hooks
*/

hook.Add("PlayerInitialSpawn", "perkInitialSpawn", function( ply )
	ply:perkGetData()
	
	timer.Simple(1, function()
		net.Start("perkMenu")
		net.Send(ply)
	end)
end)

hook.Add("PlayerDisconnected", "perkPlayerDisconnected", function( ply )
	ply:perkSaveData()
end)

hook.Add("PlayerSay", "perkMenu", function( ply, txt, tm )
	if string.find(txt, "!perk") then
		ply:ConCommand("perkMenu")
		
		return ""
	end
end)

hook.Add("ShutDown", "perkShutDown", function( )
	for k, v in pairs(player.GetAll()) do
		v:perkSaveData()
	end
end)

/*
	Functions
*/

function FindPlayer( str )
	if !str then return false end
	
	for k, v in pairs(player.GetAll()) do
		if string.find(v:Name(), str) then
			return v
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if string.find(v:SteamID(), str) then
			return v
		end
	end
	
	return nil
end

/*
	Commands
*/

concommand.Add("perk_xp", function( p, c, a )
	if !perkAdmin then p:ChatPrint("Server owner has disabled this use.") return end
	if ulx and !table.HasValue(perkGiveGroups, string.lower(p:GetUserGroup())) then p:ChatPrint("You don't have access to this command.") return end
	if !a[1] or !a[2] or !a[3] then p:ChatPrint("You forgot to provide an argument.\nperk_xp <add/take> <name/steamid> <amount>.") return end
	
	if string.find(a[2], "STEAM_") then
		a[2] = a[2] .. a[3] .. a[4] .. a[5] .. a[6]
		
		a[3] = a[#a]
	end
	
	if a[1] == "add" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkAddXP(tonumber(a[3]))
				
				p:ChatPrint("You gave " .. ply:Nick() .. " " .. a[3] .. " xp.")
				ply:ChatPrint(p:Nick() .. " gave you " .. a[3] .. " xp.")
			else
				p:ChatPrint("The player your are trying to give xp to doesn't exist.")
			end
		end
	elseif a[1] == "take" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkTakeXP(tonumber(a[3]))
				
				p:ChatPrint("You took " .. ply:Nick() .. " " .. a[3] .. " xp.")
				ply:ChatPrint(p:Nick() .. " took " .. a[3] .. " xp.")
			else
				p:ChatPrint("The player your are trying to take xp to doesn't exist.")
			end
		end
	end
end)

concommand.Add("perk_lvl", function( p, c, a )
	if !perkAdmin then p:ChatPrint("Server owner has disabled this use.") return end
	if ulx and !table.HasValue(perkGiveGroups, string.lower(p:GetUserGroup())) then p:ChatPrint("You don't have access to this command.") return end
	if !a[1] or !a[2] or !a[3] then p:ChatPrint("You forgot to provide an argument.\nperk_lvl <add/take> <name/steamid> <amount>.") return end
	
	if string.find(a[2], "STEAM_") then
		a[2] = a[2] .. a[3] .. a[4] .. a[5] .. a[6]
		
		a[3] = a[#a]
	end
	
	if a[1] == "add" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkAddLevel(tonumber(a[3]))
				
				p:ChatPrint("You gave " .. ply:Nick() .. " " .. a[3] .. " level(s).")
				ply:ChatPrint(p:Nick() .. " gave you " .. a[3] .. " level(s).")
			else
				p:ChatPrint("The player your are trying to give a level to doesn't exist.")
			end
		end
	elseif a[1] == "take" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkTakeLevel(tonumber(a[3]))
				
				p:ChatPrint("You took " .. ply:Nick() .. " " .. a[3] .. " level(s).")
				ply:ChatPrint(p:Nick() .. " took " .. a[3] .. " level(s).")
			else
				p:ChatPrint("The player your are trying to take a level from to doesn't exist.")
			end
		end
	end
end)

concommand.Add("perk_points", function( p, c, a )
	if !perkAdmin then p:ChatPrint("Server owner has disabled this use.") return end
	if ulx and !table.HasValue(perkGiveGroups, string.lower(p:GetUserGroup())) then p:ChatPrint("You don't have access to this command.") return end
	if !a[1] or !a[2] or !a[3] then p:ChatPrint("You forgot to provide an argument.\nperk_points <add/take> <name/steamid> <amount>.") return end
	
	if string.find(a[2], "STEAM_") then
		a[2] = a[2] .. a[3] .. a[4] .. a[5] .. a[6]
		
		a[3] = a[#a]
	end
	
	if a[1] == "add" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkAddPoints(tonumber(a[3]))
				
				p:ChatPrint("You gave " .. ply:Nick() .. " " .. a[3] .. " points.")
				ply:ChatPrint(p:Nick() .. " gave you " .. a[3] .. " points.")
			else
				p:ChatPrint("The player your are trying to give a point from to doesn't exist.")
			end
		end
	elseif a[1] == "take" then
		if a[2] then
			local ply = FindPlayer(a[2])
			
			if IsValid(ply) then
				ply:perkTakePoints(tonumber(a[3]))
				
				p:ChatPrint("You took " .. ply:Nick() .. " " .. a[3] .. " points.")
				ply:ChatPrint(p:Nick() .. " took " .. a[3] .. " points.")
			else
				p:ChatPrint("The player your are trying to take a point from to doesn't exist.")
			end
		end
	end
end)

concommand.Add("perk_get", function( p, c, a )
	if !perkAdmin then p:ChatPrint("Server owner has disabled this use.") return end
	if ulx and !table.HasValue(perkGiveGroups, string.lower(p:GetUserGroup())) then p:ChatPrint("You don't have access to this command.") return end
	if !a[1] then p:ChatPrint("You forgot to provide an argument.\nperk_get <name/steamid>.") return end
	
	if string.find(a[1], "STEAM_") then
		a[1] = a[1] .. a[2] .. a[3] .. a[4] .. a[5]
	end
	
	if a[1] then
		local ply = FindPlayer(a[1])
		
		if IsValid(ply) then
			p:ChatPrint(ply:Nick() .. "(" .. ply:SteamID() .. ") xp:" .. ply.perkXP .. " level:" .. ply.perkLevel .. " points:" .. ply.perkPoints .. ".")
		else
			p:ChatPrint("The player your are trying to give a point from to doesn't exist.")
		end
	end
end)

concommand.Add("perk_getall", function( p, c, a )
	if !perkAdmin then p:ChatPrint("Server owner has disabled this use.") return end
	if ulx and !table.HasValue(perkGiveGroups, string.lower(p:GetUserGroup())) then p:ChatPrint("You don't have access to this command.") return end
	
	for k, ply in pairs(player.GetAll()) do
		p:ChatPrint(ply:Nick() .. "(" .. ply:SteamID() .. ") xp:" .. ply.perkXP .. " level:" .. ply.perkLevel .. " points:" .. ply.perkPoints .. ".")
	end
end)

/*
	Networking
*/

util.AddNetworkString("perkMenu")
util.AddNetworkString("addPerk")
util.AddNetworkString("resetPerk")
util.AddNetworkString("resetPerks")
util.AddNetworkString("clientPerks")

net.Receive("addPerk", function( l, ply )
	if ply:perkGetPoints() > 0 then
		ply:perkAddPerk(net.ReadFloat())
	else
		ply:ChatPrint("You don't have enough perk points to add this.")
		ply:ChatPrint("Try leveling up to gain some perk points.")
	end
end)

net.Receive("resetPerk", function( l, ply )
	ply:perkResetData()
end)

/*
	Player Meta
*/

local Player = FindMetaTable("Player")

function Player:perkResetData()
	if self.perkPoints == 0 then self:ChatPrint("You haven't gained any points to spend. No need for a reset.") return end
	
	self:ChatPrint("Your perks have been reset.")
	
	self.perkPoints = tonumber(self:GetPData("perkPerksGained", 0))
	self.perkPerks = {}
	
	self:SetNWInt("perkPoints", self.perkPoints)
	
	net.Start("resetPerks")
	net.Send(self)
end

function Player:perkGetData()
	self.perkXP = self:GetPData("perkXP", 0)
	self.perkLevel = self:GetPData("perkLevel", 1)
	self.perkPoints = self:GetPData("perkPoints", 0)
	self.perkPerks = self:GetPData("perkPerks", 0)
	self.perkPerksGained = self:GetPData("perkPerksGained", 0)
	
	if self.perkXP == nil or self.perkXP == "" then
		self.perkXP = 0
	else
		self.perkXP = tonumber(self.perkXP)
	end
	
	if self.perkLevel == nil or self.perkLevel == "" then
		self.perkLevel = 1
	else
		self.perkLevel = tonumber(self.perkLevel)
	end
	
	if self.perkPoints == nil or self.perkPoints == "" then
		self.perkPoints = 0
	else
		self.perkPoints = tonumber(self.perkPoints)
	end
	
	if self.perkPerks == nil or self.perkPerks == "" then
		self.perkPerks = {}
	else
		self.perkPerks = util.JSONToTable(self.perkPerks)
		
		if type(self.perkPerks) == "table" and table.Count(self.perkPerks) > 0 then
			net.Start("clientPerks")
				net.WriteTable(self.perkPerks)
			net.Send(self)
		end
	end
	
	if self.perkPerksGained == nil or self.perkPerksGained == "" then
		self.perkPerksGained = 0
	else
		self.perkPerksGained = tonumber(self.perkPerksGained)
	end
	
	self:SetNWInt("perkXP", self.perkXP)
	self:SetNWInt("perkLevel", self.perkLevel)
	self:SetNWInt("perkPoints", self.perkPoints)
end

function Player:perkSaveData()
	local str
	str = self.perkPerks
	
	if str != nil then
		str = util.TableToJSON(self.perkPerks)
	else
		str = ""
	end
	
	if self.perkXP != nil or self.perkXP != "" then
		self:SetPData("perkXP", tonumber(self.perkXP))
	else
		self.perkXP = 0
		self:ChatPrint("XP value was nil. The value was reset.")
		
		self:perkSaveData()
	end
	
	if self.perkLevel != nil or self.perkLevel != "" then
		self:SetPData("perkLevel", tonumber(self.perkLevel))
	else
		self.perkLevel = 0
		self:ChatPrint("Level value was nil. The value was reset.")
		
		self:perkSaveData()
	end
	
	if self.perkPoints != nil or self.perkPoints != "" then
		self:SetPData("perkPoints", tonumber(self.perkPoints))
	else
		self.perkPoints = 0
		self:ChatPrint("Points value was nil. The value was reset.")
		
		self:perkSaveData()
	end
	
	if self.perkPerks != nil or self.perkPerks != "" then
		self:SetPData("perkPerks", str)
	else
		self.perkPerksGained = {}
		self:ChatPrint("Perks table was nil. The table was reset.")
		
		self:perkSaveData()
	end
	
	if self.perkPerksGained != nil or self.perkPerksGained != "" then
		self:SetPData("perkPerksGained", self.perkPerksGained)
	else
		self.perkPerksGained = 0
		self:ChatPrint("Perks Gained value was nil. The value was reset.")
		
		self:perkSaveData()
	end
end

function Player:perkGetLevel( )
	return self.perkLevel or 1
end

function Player:perkAddLevel( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkLevel then
		self.perkLevel = 1
	end
	
	if perkPointCap then
		local num = perkLevelCap / 5
		local nums = {}
		
		for i=1, num do
			if 5 * i <= perkLevelCap then
				table.insert(nums, 5 * i)
			end
		end
		
		if table.HasValue(nums, (self.perkLevel + n)) then
			if self.perkPerksGained < table.Count(nums) then
				timer.Simple(0.2, function()
					self.perkPerksGained = self.perkPerksGained + 1
					self:perkAddPoints(1)
				end)
			end
		end
	else
		if self.perkPerksGained then
			if self.perkPerksGained < perkLevelCap then
				timer.Simple(0.2, function()
					self.perkPerksGained = self.perkPerksGained + 1
					self:perkAddPoints(1)
				end)
			end
		else
			self.perkPerksGained = 0
		end
	end
	
	if self.perkLevel + n > perkLevelCap then
		if self.perkLevel != perkLevelCap then
			self:ChatPrint("You've leveled up (" .. self.perkLevel .. ").")
		end
		
		self.perkLevel = perkLevelCap
		
		self:SetNWInt("perkLevel", self.perkLevel)
		self:SetNWInt("perkXP", self.perkLevel * 1357)
		
		self:perkSaveData()
		
		self:perkGetData()
		
		return
	end
	
	self.perkLevel = self.perkLevel + n
	
	self:SetNWInt("perkLevel", self.perkLevel)
	self:SetNWInt("perkXP", self.perkLevel * 1357)
	
	self:perkSaveData()
	
	self:ChatPrint("You've leveled up (" .. self.perkLevel .. ").")
	
	self:perkGetData()
end

function Player:perkTakeLevel( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkLevel then
		self.perkLevel = 1
		
		self:SetNWInt("perkLevel", self.perkLevel)
		
		self:ChatPrint("You've lost a level(" .. self.perkLevel .. ").")
		
		return false
	end
	
	if self.perkPerksGained >= 1 then
		self.perkPerksGained = self.perkPerksGained - 1
	else
		self.perkPerksGained = 0
	end
	
	if self.perkLevel - n <= 0 then
		self.perkLevel = 1
		
		self:SetNWInt("perkLevel", self.perkLevel)
		
		self:ChatPrint("You've lost some xp you are now level(" .. self.perkLevel .. ").")
		
		return false
	end
	
	self.perkLevel = self.perkLevel - n
	self:SetNWInt("perkLevel", self.perkLevel)
	
	self:ChatPrint("You've lost some xp you are now level(" .. self.perkLevel .. ").")
end

function Player:perkGetXP( )
	return self.perkXP or 0
end

function Player:perkAddXP( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkXP then
		self.perkXP = 0
	end
	
	if self:perkHasPerk("Swift Learner") then
		n = n + math.Round(n * self:perkGetPercent("Swift Learner"))
	end
	
	if ulx then
		if table.HasValue(perkGroups, self:GetUserGroup()) then
			n = n + math.Round(n * 0.05)
		end
	end
	
	if self.perkLevel >= perkLevelCap then
		self.perkXP = (perkLevelCap * 1357)
		
		return
	end
	
	if (self.perkXP + n) >= (self.perkLevel * 1357) then
		if (self.perkXP + n) > (self.perkLevel * 1357) then
			local num = math.Round((self.perkXP + n) - self.perkLevel * 1357)
			
			self.perkXP = 0
			
			self:SetNWInt("perkXP", self.perkXP)
			
			self:perkAddLevel(1)
			
			self:perkAddXP(num)
			
			return
		else
			self.perkXP = 0
			
			self:SetNWInt("perkXP", self.perkXP)
			
			self:perkAddLevel(1)
			
			return
		end
	end
	
	self.perkXP = self.perkXP + n
	
	self:SetNWInt("perkXP", self.perkXP)
end

function Player:perkTakeXP( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkXP then
		self.perkXP = 0
	end
	
	if (self.perkXP - n) <= 0 then
		self.perkXP = 0
		
		if self.perkLevel > 1 then
			
			if n > self.perkXP then
				self:perkTakeLevel(math.Round(math.Clamp(self.perkXP / 1357, 1, self.perkLevel)))
				
				self.perkXP = self.perkLevel * 1357
				
				self:SetNWInt("perkXP", self.perkXP)
			else
				self:perkTakeLevel(math.Round(math.Clamp(self.perkXP / 1357, 1, self.perkLevel)))
				
				self.perkXP = n
				
				self:SetNWInt("perkXP", self.perkXP)
			end
		end
		
		return
	end
	
	self.perkXP = self.perkXP - n
	
	self:SetNWInt("perkXP", self.perkXP)
end

function Player:perkGetPerks()
	return self.perkPerks or {}
end

function Player:perkAddPerk( idx )
	idx = tonumber(idx)
	
	if table.HasValue(self.perkPerks, idx) then self:ChatPrint("What are you doing? You already have this perk.") return end
	
	if !self.perkPerks then
		self.perkPerks = {}
	end
	
	if PERKS[idx][5] then
		if !ulx and !table.HasValue(perkVIPGroups, string.lower(self:GetUserGroup())) then
			self:ChatPrint("This perk is vip only. Consider donating to gain access to this perk.")
			
			return
		end
		
		self:ChatPrint("This perk is vip only. Consider donating to gain access to this perk.")
		return
	end
	
	table.insert(self.perkPerks, idx)
	
	self:perkTakePoints(1)
	
	self:ChatPrint("Successfully gained " .. PERKS[idx][1] .. ".")
	
	net.Start("clientPerks")
		net.WriteTable(self.perkPerks)
	net.Send(self)
end

function Player:perkTakePerk( idx )
	idx = tonumber(idx)
	
	if !self.perkPerks or !table.HasValue(self.perkPerks, idx) then self:ChatPrint("What are you doing? You don't even have this perk.") return end
	
	if table.HasValue(self.perkPerks, idx) then
		table.RemoveByValue(self.perkPerks, idx)
	end
	self:ChatPrint(tostring(table.HasValue(self.perkPerks, idx)))
	
	net.Start("clientPerks")
		net.WriteTable(self.perkPerks)
	net.Send(self)
end

function Player:perkHasPerk( str )
	if self.perkPerks == nil or self.perkPerks == {} then return end
	
	local idx
	for k, v in pairs(PERKS) do
		if v[1] == str then
			idx = k
		end
	end
	
	for k, v in pairs(self.perkPerks) do
		if v == idx then
			return true
		end
	end
	
	return false
end

function Player:perkGetPoints()
	return self.perkPoints
end

function Player:perkAddPoints( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkPoints then
		self.perkPoints = 0
	end
	
	self.perkPoints = tonumber(self.perkPoints) + n
	self:SetNWInt("perkPoints", self.perkPoints)
	
	self:ChatPrint("You gain 1 perk points for reaching level " .. self.perkLevel .. ".")
end

function Player:perkTakePoints( n )
	n = tonumber(n)
	n = math.Round(n)
	
	if !self.perkPoints then
		self.perkPoints = 0
	end
	
	if (self.perkPoints - n) < 0 then
		self.perkPoints = 0
		
		self:SetNWInt("perkPoints", self.perkPoints)
		
		return
	end
	
	self.perkPoints = tonumber(self.perkPoints) - n
	self:SetNWInt("perkPoints", self.perkPoints)
end

function Player:perkGetPercent( str )
	for k, v in pairs(PERKS) do
		if v[1] == str then
			return (tonumber(v[3]) / 100)
		end
	end
	
	return 1
end