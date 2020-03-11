
/*
	Config
*/

perkKey = KEY_F6 // Which key you want the menu to show up when pressed. Refer to this for the key you want. http://wiki.garrysmod.com/page/Enums/KEY
perkAdmin = true // Can ulx super admins use console commands to give.
perkGroups = { "vip", "superadmin", "admin" } // Ulx groups that earn +5% more xp.
perkPointCap = false // Wheather you wish to have perk points given every 5 levels (true) or every 1 level (false).
perkLevelCap = 30 // What you want the max level to be.
perkXPKill = 10 // The kill earned per correct kill (its takes double xp away for incorrect kills)
perkGiveGroups = { "owner", "superadmin" } // Ulx groups that can give or take xp, level, and points.
perkVIPGroups = { "donator", "vip" } // Ulx groups that can add vip perks.

/*
	PERKS
*/

PERKS = {}

function AddPerk( idx, name, lvl, perc, desc, vip )
	PERKS[idx] = { name, lvl, perc, desc, vip }
end

AddPerk(1, "Gun Nut", 2, 5, "% more damage with pistols.", false)
AddPerk(2, "Little Leaguer", 2, 5, "% more damage with melee.", false)
AddPerk(3, "Swift Learner", 2, 5, "% more xp.", false)
AddPerk(4, "Bloody Mess", 6, 5, "% more damage.", false)
AddPerk(5, "Toughness", 6, 10, "% reduction in overall damage.", false)
AddPerk(6, "Gunslinger", 6, 25, "% better accuracy with pistols.", false)
AddPerk(7, "Commando", 8, 25, "% better accuracy with rifles.", false)
AddPerk(9, "Finesse", 10, 5, "% critical shot chance.", false)
AddPerk(10, "Nerd Rage", 10, 15, "% more damage when your\nhealth drops to 20hp.", false)
AddPerk(11, "Life Giver", 12, 25, "% more base health.", false)
AddPerk(12, "Adm. Skeleton", 14, 25, "% reduction in limb damage.", false)
AddPerk(13, "Travel Light", 15, 10, "% faster walk speed.", false)
//AddPerk(14, "Vip Perk", 15, 10, "% more special than everyone\nelse.", true) -- Example vip perk the last var is set to `true` because its vip only
