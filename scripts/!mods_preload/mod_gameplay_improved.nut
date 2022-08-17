local gt = this.getroottable();
gt.gameplay_improved <- {};

::mods_registerMod("mod_gameplay_improved", 1.00, "Gameplay Improved");
::mods_queue("mod_gameplay_improved", "mod_legends, >mod_legends_PTR, >mod_anatomists_expanded", function()
{
	//Feature: undetected crime
	::mods_hookExactClass("scripts/factions/city_state_faction", function (o)
	{
		local addPlayerRelation = ::mods_getMember(o, "addPlayerRelation");
		o.addPlayerRelation = function(_r, _reason = "")
		{
			if (_reason == "Attacked them" && !gt.gameplay_improved.roll_detection()) return;
			addPlayerRelation(_r, _reason);
		}
	});

	::mods_hookExactClass("scripts/factions/noble_faction", function (o)
	{
		local addPlayerRelation = ::mods_getMember(o, "addPlayerRelation");
		o.addPlayerRelation = function(_r, _reason = "")
		{
			if (_reason == "Attacked them" && !gt.gameplay_improved.roll_detection()) return;
			addPlayerRelation(_r, _reason);
		}
	});

	::mods_hookExactClass("scripts/factions/city_state_faction", function (o)
	{
		local addPlayerRelation = ::mods_getMember(o, "addPlayerRelation");
		o.addPlayerRelation = function(_r, _reason = "")
		{
			if (_reason == "Attacked them" && !gt.gameplay_improved.roll_detection()) return;
			addPlayerRelation(_r, _reason);
		}
	});

	gt.gameplay_improved.hook_backgrounds();
});

gt.gameplay_improved.roll_detection <- function ()
{
	local detection_chance = 60;
	local roster = this.World.getPlayerRoster().getAll();
	foreach( i, bro in roster )
	{
		if (i >= 25)
		{
			break;
		}
		if (bro.getSkills().hasSkill("trait.entertrainer")) detection_chance -= 5;
		if (bro.getSkills().hasSkill("trait.tracker")) detection_chance -= 5;
	}
	detection_chance = this.Math.max(5, detection_chance);

	local rand = this.Math.rand(1.0, 100.0);
	this.logInfo("Rolling for detection: " + rand + " vs " + detection_chance)

	return rand <= detection_chance;
}

gt.gameplay_improved.count_role <- function (role)
{
	local count = 0;
	local roster = this.World.getPlayerRoster().getAll();
	foreach( i, bro in roster )
	{
		if (i >= 25)
		{
			break;
		}
		if (bro.getSkills().hasSkill(role)) count++;
	}
	return count;
}

gt.Const.FactionTrait <- {
	None = 0,
	Warmonger = 1,
	Schemer = 2,
	Sheriff = 3,
	Collector = 4,
	Tyrant = 5,
	ManOfThePeople = 6,
	Marauder = 7,
	NobleHouse = 8,
	TradingCompany = 9,
	Settlement = 10,
	Bandit = 11,
	Orc = 12,
	Goblin = 13,
	Undead = 14,
	Zombies = 15,
	Beasts = 16,
	Barbarians = 17,
	OrientalCityState = 18,
	OrientalBandits = 19,
	FreeCompany = 20,
	Actions = [
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		[],
		//Noble House
		[
			"scripts/factions/contracts/patrol_action",
			"scripts/factions/contracts/raze_attached_location_action",
			"scripts/factions/contracts/destroy_orc_camp_action",
			"scripts/factions/contracts/destroy_goblin_camp_action",
			"scripts/factions/contracts/escort_envoy_action",
			"scripts/factions/contracts/marauding_greenskins_action",
			"scripts/factions/contracts/raid_caravan_action",
			"scripts/factions/contracts/big_game_hunt_action",
			"scripts/factions/contracts/barbarian_king_action",
			"scripts/factions/contracts/free_greenskin_prisoners_action",
			"scripts/factions/contracts/confront_warlord_action",
			"scripts/factions/contracts/break_siege_action",
			"scripts/factions/contracts/find_artifact_action",
			"scripts/factions/contracts/last_stand_action",
			"scripts/factions/contracts/root_out_undead_action",
			"scripts/factions/contracts/decisive_battle_action",
			"scripts/factions/contracts/privateering_action",
			"scripts/factions/contracts/siege_fortification_action",
			"scripts/factions/contracts/conquer_holy_site_action",
			"scripts/factions/contracts/defend_holy_site_action",
			"scripts/factions/contracts/intercept_raiding_parties_action",
			"scripts/factions/actions/defend_military_action",
			"scripts/factions/actions/move_troops_action",
			"scripts/factions/actions/patrol_roads_action",
			"scripts/factions/actions/send_ship_action",
			"scripts/factions/actions/receive_ship_action",
			"scripts/factions/actions/burn_location_action",
			"scripts/factions/actions/rebuild_location_action",
			"scripts/factions/actions/legend_build_location_action",
			"scripts/factions/actions/legend_upgrade_settlement_action",
			"scripts/factions/actions/send_supplies_action",
			"scripts/factions/actions/add_random_situation_action",
			"scripts/factions/actions/send_military_army_action",
			"scripts/factions/contracts/legend_hunting_white_direwolf_action",
			"scripts/factions/contracts/legend_hunting_stollwurms_action",
			"scripts/factions/contracts/legend_hunting_rock_unholds_action",
			"scripts/factions/contracts/legend_hunting_redback_webknechts_action",
			"scripts/factions/contracts/legend_hunting_greenwood_schrats_action",
			"scripts/factions/contracts/legend_hunting_demon_alps_action",
			"scripts/factions/contracts/legend_hunting_coven_leader_action",
			"scripts/factions/contracts/legend_hunting_skin_ghouls_action",
			"scripts/factions/contracts/legend_bandit_army_action",
			"scripts/factions/contracts/legend_barbarian_prisoner_action",
			"scripts/factions/actions/send_military_holysite_action"
		],
		[],
		//Settlement
		[
			//general contracts
			"scripts/contracts/contracts/gi_stolenitm_A",
			// "scripts/factions/contracts/drive_away_bandits_action",
			// "scripts/factions/contracts/drive_away_barbarians_action",
			// "scripts/factions/contracts/investigate_cemetery_action",
			// "scripts/factions/contracts/item_delivery_action",
			// "scripts/factions/contracts/money_delivery_action",
			// "scripts/factions/contracts/escort_caravan_action",

			// //monster hunt
			// "scripts/factions/contracts/roaming_beasts_action",
			// "scripts/factions/contracts/obtain_item_action",
			// "scripts/factions/contracts/hunting_webknechts_action",
			// "scripts/factions/contracts/hunting_alps_action",
			// "scripts/factions/contracts/hunting_unholds_action",
			// "scripts/factions/contracts/hunting_hexen_action",
			// "scripts/factions/contracts/hunting_schrats_action",
			// "scripts/factions/contracts/hunting_lindwurms_action",
			// "scripts/factions/contracts/legend_hunting_white_direwolf_action",
			// "scripts/factions/contracts/legend_hunting_stollwurms_action",
			// "scripts/factions/contracts/legend_hunting_rock_unholds_action",
			// "scripts/factions/contracts/legend_hunting_redback_webknechts_action",
			// "scripts/factions/contracts/legend_hunting_greenwood_schrats_action",
			// "scripts/factions/contracts/legend_hunting_demon_alps_action",
			// "scripts/factions/contracts/legend_hunting_coven_leader_action",
			// "scripts/factions/contracts/legend_hunting_skin_ghouls_action",

			// "scripts/factions/contracts/defend_settlement_bandits_action",
			// "scripts/factions/contracts/defend_settlement_greenskins_action",
			
			// "scripts/factions/contracts/restore_location_action",
			// "scripts/factions/contracts/discover_location_action",
			
			// "scripts/factions/contracts/legend_bandit_army_action",
			// "scripts/factions/contracts/legend_barbarian_prisoner_action",

			//housekeeping
			"scripts/factions/actions/send_caravan_action",
			"scripts/factions/actions/send_peasants_action",
			"scripts/factions/actions/defend_militia_action",
			"scripts/factions/actions/send_ship_action",
			"scripts/factions/actions/receive_ship_action",
			"scripts/factions/actions/burn_location_action",
			"scripts/factions/actions/rebuild_location_action",
			"scripts/factions/actions/legend_build_location_action",
			"scripts/factions/actions/legend_upgrade_settlement_action",
			"scripts/factions/actions/add_random_situation_action"
		],
		[
			"scripts/factions/actions/build_bandit_camp_action",
			"scripts/factions/actions/send_bandit_ambushers_action",
			"scripts/factions/actions/send_bandit_roamers_action",
			"scripts/factions/actions/defend_bandits_action",
			"scripts/factions/actions/build_unique_locations_action"
		],
		[
			"scripts/factions/actions/build_orc_camp_action",
			"scripts/factions/actions/move_orcs_action",
			"scripts/factions/actions/defend_orcs_action",
			"scripts/factions/actions/send_orc_marauders_action",
			"scripts/factions/actions/send_orc_roamers_action",
			"scripts/factions/actions/send_greenskin_army_action",
			"scripts/factions/actions/build_unique_locations_action"
		],
		[
			"scripts/factions/actions/build_goblin_camp_action",
			"scripts/factions/actions/send_goblin_ambushers_action",
			"scripts/factions/actions/send_goblin_roamers_action",
			"scripts/factions/actions/move_goblins_action",
			"scripts/factions/actions/defend_goblins_action",
			"scripts/factions/actions/send_greenskin_army_action",
			"scripts/factions/actions/build_unique_locations_action"
		],
		[
			"scripts/factions/actions/build_undead_camp_action",
			"scripts/factions/actions/send_undead_roamers_action",
			"scripts/factions/actions/defend_undead_action",
			"scripts/factions/actions/send_undead_army_action",
			"scripts/factions/actions/move_undead_action",
			"scripts/factions/actions/send_undead_ambushers_action",
			"scripts/factions/actions/build_unique_locations_action"
		],
		[
			"scripts/factions/actions/build_zombie_camp_action",
			"scripts/factions/actions/send_undead_roamers_action",
			"scripts/factions/actions/defend_undead_action",
			"scripts/factions/actions/move_undead_action",
			"scripts/factions/actions/send_undead_ambushers_action",
			"scripts/factions/actions/build_unique_locations_action"
		],
		[
			"scripts/factions/actions/send_beast_roamers_action"
		],
		[
			"scripts/factions/actions/build_barbarian_camp_action",
			"scripts/factions/actions/send_barbarian_ambushers_action",
			"scripts/factions/actions/send_barbarian_roamers_action",
			"scripts/factions/actions/defend_barbarians_action"
		],
		//City State
		[
			"scripts/factions/contracts/drive_away_nomads_action",
			"scripts/factions/contracts/roaming_beasts_desert_action",
			"scripts/factions/contracts/slave_uprising_action",
			"scripts/factions/contracts/item_delivery_action",
			"scripts/factions/contracts/escort_caravan_action",
			"scripts/factions/contracts/hunting_serpents_action",
			"scripts/factions/contracts/hunting_sand_golems_action",
			"scripts/factions/contracts/hunting_mummies_action",
			"scripts/factions/contracts/conquer_holy_site_action",
			"scripts/factions/contracts/defend_holy_site_action",
			"scripts/factions/contracts/hold_chokepoint_action",
			"scripts/factions/actions/defend_citystate_action",
			"scripts/factions/actions/send_ship_action",
			"scripts/factions/actions/receive_ship_action",
			"scripts/factions/actions/add_random_situation_action",
			"scripts/factions/actions/burn_location_action",
			"scripts/factions/actions/rebuild_location_action",
			"scripts/factions/actions/legend_build_location_action",
			"scripts/factions/actions/legend_upgrade_locations_action",
			"scripts/factions/actions/patrol_area_action",
			"scripts/factions/actions/send_peasants_action",
			"scripts/factions/actions/send_caravan_action",
			"scripts/factions/actions/send_citystate_army_action",
			"scripts/factions/actions/send_citystate_holysite_action"
		],
		[
			"scripts/factions/actions/build_nomad_camp_action",
			"scripts/factions/actions/send_nomad_ambushers_action",
			"scripts/factions/actions/send_nomad_roamers_action",
			"scripts/factions/actions/defend_nomad_action"
		],
		[]
	]
};

gt.gameplay_improved.stolenitm_string <- {
	strange_tome = "Strange Tome",
	lindwurm_bones_item = "Lindwurm Bones",
	unhold_bones_item = "Unhold Bones",
	strange_eye = "Strange Eye",
	ceremonial_staff = "Ceremonial Staff",
	heirloom_sword = "Heirloom Sword",
	legend_named_butchers_cleaver = "Heirloom Cleaver",
	legend_named_sickle = "Heirloom Sickle",
	legend_named_blacksmith_hammer = "Heirloom Hammer",
	lockbox = "Lockbox"
}

gt.gameplay_improved.stolenitm_value <- {
	strange_tome = 10000,
	lindwurm_bones_item = 2200,
	unhold_bones_item = 1125,
	strange_eye = 1000,
	ceremonial_staff = 2000,
	heirloom_sword = 4000,
	legend_named_butchers_cleaver = 1100,
	legend_named_sickle = 4500,
	legend_named_blacksmith_hammer = 5000,
	lockbox = 1000
}
gt.gameplay_improved.stolenitm_item <- {
	lindwurm_bones_item = "scripts/items/misc/lindwurm_bones_item",
	unhold_bones_item = "scripts/items/misc/unhold_bones_item",
	strange_eye = "scripts/items/misc/strange_eye_item",
	legend_named_butchers_cleaver = "scripts/items/weapons/named/legend_named_butchers_cleaver",
	legend_named_sickle = "scripts/items/weapons/named/legend_named_sickle",
	legend_named_blacksmith_hammer = "scripts/items/weapons/named/legend_named_blacksmith_hammer",
	ceremonial_staff = "scripts/items/weapons/named/legend_staff_ceremonial"
}

gt.gameplay_improved.StaffNames <- [
	"Deathdealer",
	"Mercy",
	"Slayer",
	"Oathkeeper",
	"Avenger",
	"Red Rivers",
	"Lightning",
	"Striker",
	"Windcatcher",
	"Swiftstrike"
];
