if !string.find(string.lower(engine.ActiveGamemode()), "darkrp") then return end

/*
	The following of code is for darkrp.
*/


/*
	DarkRP vars
*/

perkXPJob = 25 // The amount of xp to be given on payday.
perkXPDeath = 10 // The amount of xp taken from the player if they die.

/*
	Hooks
*/

hook.Add("PlayerSpawn", "perkPlayerSpawn", function( ply )
	if ply:perkHasPerk("Life Giver") then
		ply:SetHealth(ply:Health() + (ply:Health() * ply:perkGetPercent("Life Giver")))
	end
	
	if ply:perkHasPerk("Travel Light") then
		ply:SetWalkSpeed(ply:GetWalkSpeed() + (ply:GetWalkSpeed() * ply:perkGetPercent("Travel Light")))
	end
end)

hook.Add("playerGetSalary", "perkGetSalary", function( ply, num )
	ply:perkAddXP(perkXPJob)
	ply:perkSaveData()
end)

hook.Add("PlayerDeath", "perkPlayerDeath", function( ply, dmg, pl )
	if ply:IsPlayer() and pl:IsPlayer() and ply != pl then
		pl:perkAddXP(perkXPKill)
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
