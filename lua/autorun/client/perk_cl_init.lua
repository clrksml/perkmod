/*
	Fonts
*/

surface.CreateFont("ITC Avant Garde Pro XXLt", { font = "ITC Avant Garde Pro XLt", size = 16, weight = 700, antialias = true, shadow = false } )
surface.CreateFont("ITC Avant Garde Pro Lt I", { font = "ITC Avant Garde Pro XLt", size = 24, weight = 800, antialias = true, shadow = false, italic = true } )
surface.CreateFont("ITC Avant Garde Pro Lt", { font = "ITC Avant Garde Pro XLt", size = 24, weight = 1000, antialias = true, shadow = false } )
surface.CreateFont("ITC Avant Garde Pro 8k", { font = "ITC Avant Garde Pro 8k", size = 24, weight = 1000, antialias = true, shadow = false } )
surface.CreateFont("ITC Avant Garde Pro Md", { font = "ITC Avant Garde Pro Md", size = 48, weight = 1000, antialias = true, shadow = false } )
surface.CreateFont("ITC Avant Garde Pro XLt", { font = "ITC Avant Garde Pro XLt", size = 18, antialias = true, shadow = false } )

/*
	Menu
*/

local perks = {}
local selected = "Gun Nut"
function perkMenu()
	PerkMenu = vgui.Create("DFrame")
	PerkMenu:SetSize(550, 400)
	PerkMenu:Center()
	PerkMenu:SetTitle("")
	PerkMenu:SetSizable(false)
	PerkMenu:ShowCloseButton(false)
	PerkMenu:MakePopup()
	PerkMenu.Paint = function()
		draw.RoundedBox(2, 0, 0, PerkMenu:GetWide(), PerkMenu:GetTall(), Color(35, 35, 35))
	end
	
	local XPLabel = vgui.Create("DLabel", PerkMenu)
	XPLabel:SetPos(4, 1)
	XPLabel:SetText("XP: " .. LocalPlayer():GetNWInt("perkXP", 0) .. "/" .. (LocalPlayer():GetNWInt("perkLevel", 1) * 1357) .. " ")
	XPLabel:SetTextColor(Color(255, 255, 255))
	XPLabel:SetFont("ITC Avant Garde Pro XLt")
	XPLabel:SizeToContents()
	XPLabel.Think = function()
		if LocalPlayer():GetNWInt("perkLevel", 1) >= perkLevelCap  then
			XPLabel:SetText("XP: Max XP ")
			XPLabel:SizeToContents()
		else
			XPLabel:SetText("XP: " .. LocalPlayer():GetNWInt("perkXP", 0) .. "/" .. (LocalPlayer():GetNWInt("perkLevel", 1) * 1357) .. " ")
			XPLabel:SizeToContents()
		end
	end
	
	local LevelLabel = vgui.Create("DLabel", PerkMenu)
	LevelLabel:SetPos(4, 1)
	LevelLabel:SetText(" Level: " .. LocalPlayer():GetNWInt("perkLevel", 1) .. " ")
	LevelLabel:SetTextColor(Color(255, 255, 255))
	LevelLabel:SetFont("ITC Avant Garde Pro XLt")
	LevelLabel:SizeToContents()
	LevelLabel:MoveRightOf(XPLabel)
	LevelLabel.Think = function()
		LevelLabel:SetText(" Level: " .. LocalPlayer():GetNWInt("perkLevel", 1) .. " ")
		LevelLabel:MoveRightOf(XPLabel)
	end
	
	local PointsLabel = vgui.Create("DLabel", PerkMenu)
	PointsLabel:SetPos(4, 1)
	PointsLabel:SetText(" Points: " .. LocalPlayer():GetNWInt("perkPoints", 0) .. " ")
	PointsLabel:SetTextColor(Color(255, 255, 255))
	PointsLabel:SetFont("ITC Avant Garde Pro XLt")
	PointsLabel:SizeToContents()
	PointsLabel:MoveRightOf(LevelLabel)
	PointsLabel.Think = function()
		PointsLabel:SetText(" Points: " .. LocalPlayer():GetNWInt("perkPoints", 0) .. " ")
		PointsLabel:MoveRightOf(LevelLabel)
	end
	
	local ResetButton = vgui.Create("DButton", PerkMenu)
	ResetButton:SetSize(50, 20)
	ResetButton:SetPos(296, 1)
	ResetButton:SetText("RESET")
	ResetButton:SetTextColor(Color(255, 255, 255))
	ResetButton:SetFont("ITC Avant Garde Pro XXLt")
	ResetButton.DoClick = function()
		PerkMenu:Close()
		
		net.Start("resetPerk")
		net.SendToServer()
		
		perkMenu()
	end
	ResetButton.Think = function()
		ResetButton:MoveRightOf(PointsLabel)
	end
	ResetButton.Paint = function()
		draw.RoundedBox(2, 0, 0, ResetButton:GetWide(), ResetButton:GetTall(), Color(255, 104, 104))
	end
	
	local CloseButton = vgui.Create("DButton", PerkMenu)
	CloseButton:SetSize(50, 20)
	CloseButton:SetPos(496, 1)
	CloseButton:SetText("CLOSE")
	CloseButton:SetTextColor(Color(255, 255, 255))
	CloseButton:SetFont("ITC Avant Garde Pro XXLt")
	CloseButton.DoClick = function()
		PerkMenu:Close()
	end
	CloseButton.Paint = function()
		draw.RoundedBox(2, 0, 0, CloseButton:GetWide(), CloseButton:GetTall(), Color(255, 104, 104))
	end
	
	PerkMenu.Refresh = function()
		local PerkScroll = vgui.Create("DScrollPanel", PerkMenu)
		PerkScroll:SetSize(220, 360)
		PerkScroll:SetPos(5, 30)
		PerkScroll.Paint = function()
			draw.RoundedBox(2, 0, 0, PerkScroll:GetWide(), PerkScroll:GetTall(), Color(25, 25, 25))
		end
		PerkScroll.Refresh = function()
			local PerkLayout = vgui.Create("DIconLayout", PerkScroll)
			PerkLayout:SetPos(0, 0)
			PerkLayout:SetSize(PerkScroll:GetWide(), PerkScroll:GetTall())
			PerkLayout:SetSpaceX(2)
			PerkLayout:SetSpaceY(2)
			
			for k, v in SortedPairs(PERKS) do
				local PerkPanel = PerkLayout:Add("DPanel")
				PerkPanel:SetSize(PerkScroll:GetWide(), 60)
				PerkPanel.Paint = function()
					draw.RoundedBox(2, 0, 0, PerkScroll:GetWide(), PerkScroll:GetTall(), Color(30, 30, 30))
				end
				
				local PerkName = vgui.Create("DLabel", PerkPanel)
				PerkName:SetPos(4, 0)
				PerkName:SetSize(PerkScroll:GetWide(), 30)
				PerkName:SetFont("ITC Avant Garde Pro 8k")
				PerkName:SetText(v[1])
				PerkName:SetTextColor(Color(255, 255, 255))
				
				if LocalPlayer():GetNWInt("perkLevel", 0) < v[2] then
					PerkName:SetTextColor(Color(180, 180, 180))
				end
				
				local PerkLevel = vgui.Create("DLabel", PerkPanel)
				PerkLevel:SetPos(4, 30)
				PerkLevel:SetSize(PerkScroll:GetWide(), 30)
				PerkLevel:SetFont("ITC Avant Garde Pro Lt I")
				PerkLevel:SetText("Lvl. " .. v[2])
				PerkLevel:SetTextColor(Color(255, 255, 255))
				
				if LocalPlayer():GetNWInt("perkLevel", 0) < v[2] then
					PerkLevel:SetTextColor(Color(180, 180, 180))
				end
				
				local PerkButton = vgui.Create("DButton", PerkPanel)
				PerkButton:SetSize(PerkScroll:GetWide(), 60)
				PerkButton:SetPos(0, 0)
				PerkButton:SetText("")
				PerkButton.Paint = function() end
				PerkButton.DoClick = function()
					selected = v[1]
					
					PerkMenu:Refresh()
				end
			end
		end
		
		local ScrollBar = PerkScroll:GetVBar()
		ScrollBar.Paint = function()
			draw.RoundedBox(2, 0, 0, ScrollBar:GetWide(), ScrollBar:GetTall(), Color(35, 35, 35))
		end
		ScrollBar.btnUp.Paint = function()
			draw.RoundedBox(2, 0, 0, ScrollBar.btnUp:GetWide(), ScrollBar.btnUp:GetTall(), Color(255, 104, 104))
		end
		ScrollBar.btnDown.Paint = function()
			draw.RoundedBox(2, 0, 0, ScrollBar.btnDown:GetWide(), ScrollBar.btnDown:GetTall(), Color(255, 104, 104))
		end
		ScrollBar.btnGrip.Paint = function()
			draw.RoundedBox(2, 0, 0, ScrollBar.btnGrip:GetWide(), ScrollBar.btnGrip:GetTall(), Color(55, 55, 55))
		end
		
		PerkScroll:Refresh()
		
		for k, v in pairs(PERKS) do
			if selected == v[1] then
				local PerkPanel = vgui.Create("DPanel", PerkMenu)
				PerkPanel:SetSize(310, 360)
				PerkPanel:SetPos(230, 30)
				PerkPanel.Paint = function()
					draw.RoundedBox(2, 0, 0, PerkPanel:GetWide(), PerkPanel:GetTall(), Color(35, 35, 35))
				end
				
				local LevelNumber = vgui.Create("DLabel", PerkPanel)
				LevelNumber:SetPos(20, 30)
				LevelNumber:SetText("Level " .. v[2])
				LevelNumber:SetTextColor(Color(255, 255, 255))
				
				if LocalPlayer():GetNWInt("perkLevel", 0) < v[2] then
					LevelNumber:SetTextColor(Color(180, 180, 180))
				end
				
				LevelNumber:SetFont("ITC Avant Garde Pro Lt")
				LevelNumber:SizeToContents()
				
				if v[5] then
					local VipOnly = vgui.Create("DLabel", PerkPanel)
					VipOnly:SetPos(20, 30)
					VipOnly:SetText("VIP")
					VipOnly:SetTextColor(Color(255, 104, 104))
					VipOnly:SetFont("ITC Avant Garde Pro Lt")
					VipOnly:SizeToContents()
					VipOnly:MoveRightOf(LevelNumber)
					
					local _x, _y = VipOnly:GetPos()
					VipOnly:SetPos(_x + 4, _y)
				end
				
				local PerkTitle = vgui.Create("DLabel", PerkPanel)
				PerkTitle:SetPos(20, 60)
				PerkTitle:SetText(v[1])
				PerkTitle:SetTextColor(Color(255, 255, 255))
				
				if LocalPlayer():GetNWInt("perkLevel", 0) < v[2] then
					PerkTitle:SetTextColor(Color(180, 180, 180))
				end
				
				PerkTitle:SetFont("ITC Avant Garde Pro Md")
				PerkTitle:SizeToContents()
				
				local PerkDescription = vgui.Create("DLabel", PerkPanel)
				PerkDescription:SetPos(20, 80)
				PerkDescription:SetSize(290, 120)
				PerkDescription:SetTextColor(Color(255, 255, 255))
				
				if LocalPlayer():GetNWInt("perkLevel", 0) < v[2] then
					PerkDescription:SetTextColor(Color(180, 180, 180))
				end
				
				PerkDescription:SetFont("ITC Avant Garde Pro XLt")
				PerkDescription:SetText(v[3] .. v[4])
				PerkDescription:SetAutoStretchVertical()
				
				if LocalPlayer():GetNWInt("perkPoints", 0) > 0 and LocalPlayer():GetNWInt("perkLevel", 0) >= v[2] and !table.HasValue(perks, k) then
					local AddButton = vgui.Create("DButton", PerkPanel)
					AddButton:SetSize(70, 30)
					AddButton:SetPos(20, 200)
					AddButton:SetText("ADD")
					AddButton:SetTextColor(Color(255, 255, 255))
					AddButton:SetFont("ITC Avant Garde Pro Lt")
					AddButton.DoClick = function()
						net.Start("addPerk")
							net.WriteFloat(k)
						net.SendToServer()
						
						selected = v[1]
						
						PerkMenu:Refresh()
					end
					AddButton.Paint = function()
						draw.RoundedBox(2, 0, 0, AddButton:GetWide(), AddButton:GetTall(), Color(0, 255, 0))
					end
				else
					if !table.HasValue(perks, k) then
						local AddButton = vgui.Create("DButton", PerkPanel)
						AddButton:SetSize(70, 30)
						AddButton:SetPos(20, 200)
						AddButton:SetText("ADD")
						AddButton:SetTextColor(Color(255, 255, 255))
						AddButton:SetFont("ITC Avant Garde Pro Lt I")
						AddButton.DoClick = function() end
						AddButton.Paint = function()
							draw.RoundedBox(2, 0, 0, AddButton:GetWide(), AddButton:GetTall(), Color(255, 0, 0))
						end
					end
				end
			end
		end
	end
	
	PerkMenu:Refresh()
end
concommand.Add("perkMenu", perkMenu)

/*
	Hooks
*/

hook.Add("Think", "perkShowMenu", function( )
	if input.IsKeyDown(perkKey) then
		if !PerkMenu or !PerkMenu:IsVisible() then
			perkMenu()
			return true
		end
	end
end)

/*
	net
*/

net.Receive("perkMenu", function( l )
	LocalPlayer():ChatPrint("[Perk Mod] You can buy perks by using " .. input.GetKeyName(perkKey) .. " menu.")
end)

net.Receive("resetPerks", function( l )
	perks = {}
end)

net.Receive("clientPerks", function( l )
	perks = net.ReadTable() or {}
end)
