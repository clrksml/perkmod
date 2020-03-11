if !string.find(string.lower(engine.ActiveGamemode()), "deathrun") then return end

/*
	The following of code is for deathrun.
	
	This file only supports Mr. Gash's deathrun which can be found here -> http://facepunch.com/showthread.php?t=1242352
*/


/*
	Deathrun vars
*/

perkXPWin = 20 // The xp earned for your team winning the round.
perkXPDeath = 10 // The amount of xp taken from the player if they die.

/*
	Hooks
*/

hook.Add("OnRoundSet", "perkOnRoundSet", function( rnd, win )
	if rnd == ROUND_ACTIVE then
		for k, v in pairs(player.GetAll()) do
			if v:perkHasPerk("Life Giver") then
				v:SetHealth(v:Health() + (v:Health() * v:perkGetPercent("Life Giver")))
			end
			
			if v:perkHasPerk("Travel Light") then
				v:SetWalkSpeed(v:GetWalkSpeed() + (v:GetWalkSpeed() * v:perkGetPercent("Travel Light")))
			end
		end
	end
	
	if rnd == ROUND_ENDING  then
		for k, v in pairs(player.GetAll()) do
			if win == v:Team() then
				v:perkAddXP(perkXPWin)
			end
			
			v:perkSaveData()
		end
	end
end)

hook.Add("PlayerDeath", "perkPlayerDeath", function( ply, dmg, pl )
	if GetRoundState() != ROUND_ACTIVE then return end
	
	if ply:IsPlayer() and pl:IsPlayer() and ply != pl then
		if ply:Team() != pl:Team() then
			pl:perkAddXP(perkXPKill)
		else
			pl:perkTakeXP(perkXPKill * 2)
		end
	end
	
	if !pl:IsPlayer() then
		if perkXPDeath > 0 then
			ply:perkTakeXP(perkXPDeath)
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
						if weapon.Primary and weapon.Primary.Damage then
							weapon.Primary.Damage = weapon.Primary.Damage + (ply:perkGetPercent("Gun Nut") * weapon.Primary.Damage)
						end
					end
				end
			end
			
			if ply:perkHasPerk("Bloody Mess") then
				if weapon.Primary and weapon.Primary.Damage then
					weapon.Primary.Damage = weapon.Primary.Damage + (ply:perkGetPercent("Bloody Mess") * weapon.Primary.Damage)
				end
			end
			
			if ply:perkHasPerk("Commando") then
				if ply:GetActiveWeapon():GetModel() != nil then
					if string.find(weapon:GetModel(), "snip") or string.find(weapon:GetModel(), "rifle")  or string.find(weapon:GetModel(), "rif") then
						if weapon.Primary.Recoil and weapon.Primary.Cone then
							weapon.Primary.Recoil = weapon.Primary.Recoil - (ply:perkGetPercent("Commando") * weapon.Primary.Recoil)
							weapon.Primary.Cone = weapon.Primary.Cone - (ply:perkGetPercent("Commando") * weapon.Primary.Cone)
						end
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
			if pl:GetActiveWeapon():GetModel() != nil and pl:GetActiveWeapon():GetModel() == "models/weapons/w_crowbar.mdl" or pl:GetActiveWeapon().HoldType and string.lower(pl:GetActiveWeapon().HoldType) == "melee" then
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
