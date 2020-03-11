if !string.find(string.lower(engine.ActiveGamemode()), "terror") then return end

/*
	The following of code is for trouble in terrorist town.
*/


/*
	TTT vars
*/

perkXPWin = 20 // The xp earned for your team winning the round.

/*
	Hooks
*/

hook.Add("TTTBeginRound", "perkBeginRound", function( )
	for k, v in pairs(player.GetAll()) do
		if v:perkHasPerk("Life Giver") then
			v:SetHealth(v:Health() + (v:Health() * v:perkGetPercent("Life Giver")))
		end
		
		if v:perkHasPerk("Travel Light") then
			v:SetWalkSpeed(v:GetWalkSpeed() + (v:GetWalkSpeed() * v:perkGetPercent("Travel Light")))
		end
	end
end)

hook.Add("TTTEndRound", "perkEndRound", function( win )
	for k, v in pairs(player.GetAll()) do
		if win == WIN_TRAITOR then
			if v:GetRole() == ROLE_TRAITOR then
				v:perkAddXP(perkXPWin)
			end
		else
			if v:GetRole() != ROLE_TRAITOR then
				v:perkAddXP(perkXPWin)
			end
		end
		
		v:perkSaveData()
	end
end)

hook.Add("PlayerDeath", "perkPlayerDeath", function( ply, dmg, pl )
	if GetRoundState() != ROUND_ACTIVE then return end
	
	if ply:IsPlayer() and pl:IsPlayer() and ply != pl then
		if !pl:IsRole(ROLE_TRAITOR) and !pl:IsRole(ROLE_DETECTIVE) then
			if !ply:IsRole(ROLE_TRAITOR) and !ply:IsRole(ROLE_DETECTIVE) then
				pl:perkTakeXP(perkXPKill * 2)
			elseif ply:IsRole(ROLE_TRAITOR) then
				pl:perkAddXP(perkXPKill)
			elseif ply:IsRole(ROLE_DETECTIVE) then
				pl:perkTakeXP(perkXPKill * 2)
			end
		elseif pl:IsRole(ROLE_TRAITOR) then
			if !ply:IsRole(ROLE_TRAITOR) and !ply:IsRole(ROLE_DETECTIVE) then
				pl:perkAddXP(perkXPKill)
			elseif ply:IsRole(ROLE_TRAITOR) then
				pl:perkTakeXP(perkXPKill * 2)
			elseif ply:IsRole(ROLE_DETECTIVE) then
				pl:perkAddXP(perkXPKill * 2)
			end
		elseif pl:IsRole(ROLE_DETECTIVE) then
			if !ply:IsRole(ROLE_TRAITOR) and !ply:IsRole(ROLE_DETECTIVE) then
				pl:perkTakeXP(perkXPKill * 2)
			elseif ply:IsRole(ROLE_TRAITOR) then
				pl:perkAddXP(perkXPKill)
			elseif ply:IsRole(ROLE_DETECTIVE) then
				pl:perkTakeXP(perkXPKill * 2)
			end
		end
	end
end)

hook.Add("WeaponEquip", "perkWeaponEquip", function( weapon )
	timer.Simple(1, function()
		if IsValid(weapon) then
			local ply = weapon:GetOwner()
			if ply:perkHasPerk("Gun Nut") then
				if weapon:GetModel() != nil then
					if string.find(weapon:GetModel(), "pistol") or string.find(weapon:GetModel(), "pist") then
						weapon.Primary.Damage = weapon.Primary.Damage + (ply:perkGetPercent("Gun Nut") * weapon.Primary.Damage)
					end
				end
			end
			
			if ply:perkHasPerk("Bloody Mess") then
				weapon.Primary.Damage = weapon.Primary.Damage + (ply:perkGetPercent("Bloody Mess") * weapon.Primary.Damage)
			end
			
			if ply:perkHasPerk("Commando") then
				if ply:GetActiveWeapon():GetModel() != nil then
					if string.find(weapon:GetModel(), "snip") or string.find(weapon:GetModel(), "rifle")  or string.find(weapon:GetModel(), "rif") then
						weapon.Primary.Recoil = weapon.Primary.Recoil - (ply:perkGetPercent("Commando") * weapon.Primary.Recoil)
						weapon.Primary.Cone = weapon.Primary.Cone - (ply:perkGetPercent("Commando") * weapon.Primary.Cone)
					end
				end
			end
		end
	end)
end)

hook.Add("ScalePlayerDamage", "perkPlayerDamage", function( ply, hit, dmg )
	if GetRoundState() != ROUND_ACTIVE then return end
	
	if IsValid(dmg:GetAttacker()) and dmg:GetAttacker():IsPlayer() then
		local pl = dmg:GetAttacker()
		local hp = dmg:GetDamage()
		
		if pl:perkHasPerk("Little Leaguer") then
			if pl:GetActiveWeapon():GetModel() != nil and pl:GetActiveWeapon():GetModel() == "models/weapons/w_crowbar.mdl" or pl:GetActiveWeapon().HoldType != nil and string.lower(pl:GetActiveWeapon().HoldType) == "melee" then
				hp = (dmg:GetDamage() * pl:perkGetPercent("Little Leaguer")) + dmg:GetDamage()
			end
		end
		
		if ply:perkHasPerk("Toughness") then
			hp = hp - (ply:perkGetPercent("Toughness") * dmg:GetDamage())
		end
		
		if ply:perkHasPerk("Adm. Skeleton") then
			if hit == HITGROUP_LEFTARM or hit == HITGROUP_RIGHTARM or hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
				hp = hp - (ply:perkGetPercent("Adm. Skeleton") * dmg:GetDamage())
			end
		end
		
		if pl:perkHasPerk("Nerd Rage") then
			if pl:Health() < 20 then
				hp = hp + (pl:perkGetPercent("Nerd Rage") * dmg:GetDamage())
			end
		end
		
		if pl:perkHasPerk("Finesse") then
			local chance = math.random(1, (100 / (pl:perkGetPercent("Finesse") * 100)))
			
			if chance == 1 then
				hp = hp + (2 * dmg:GetDamage())
			end
		end
		
		dmg:SetDamage(hp)
	end
end)
