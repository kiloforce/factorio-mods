data:extend({
	--{
	--	type = "string-setting",
	--	name = "ownlys_tracers--ammo_categories",
	--	description = "ownlys_tracers--ammo_categories",
	--	setting_type = "startup",
	--	default_value = "bullet",
	--	allow_blank = true,
	--	order = "a1",
	--	per_user = false
	--},
	--{
	--	type = "string-setting",
	--	name = "ownlys_tracers--probability",
	--	setting_type = "startup",
	--	default_value = "100%",
	--	allowed_values = {"10%", "20%", "33%", "50%", "67%", "100%"},
	--	order = "a2",
	--	per_user = false
	--},
	{
		type = "double-setting",
		name = "ownlys_tracers--speed",
		setting_type = "startup",
		default_value = 1.85,
		minimum_value = 0.5,
		maximum_value = 4.0,
		order = "a3",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--speed_deviation",
		setting_type = "startup",
		default_value = 0.5,
		minimum_value = 0.0,
		maximum_value = 1.0,
		order = "a4",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--direction_deviation",
		setting_type = "startup",
		default_value = 0.025,
		minimum_value = 0.0,
		maximum_value = 1.0,
		order = "a5",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--range",
		setting_type = "startup",
		default_value = 23,
		minimum_value = 10,
		maximum_value = 100,
		order = "a6",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--range_deviation",
		setting_type = "startup",
		default_value = 0.15,
		minimum_value = 0.0,
		maximum_value = 1.0,
		order = "a7",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--acceleration",
		setting_type = "startup",
		default_value = 0.0,
		minimum_value = -0.1,
		maximum_value = 0.1,
		order = "a8",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--scale",
		setting_type = "startup",
		default_value = 0.5,
		minimum_value = 0.1,
		maximum_value = 3,
		order = "a8",
		per_user = false
	},
	{
		type = "double-setting",
		name = "ownlys_tracers--collision_scale",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.01,
		maximum_value = 30,
		order = "a8",
		per_user = false
	},
	
	{
		type = "bool-setting",
		name = "ownlys_tracers--misfires",
		setting_type = "startup",
		default_value = false,
		order = "a9",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "ownlys_tracers--directional_targeting",
		setting_type = "startup",
		default_value = false,
		order = "a99",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "ownlys_tracers--player_lead_target",
		setting_type = "startup",
		default_value = false,
		order = "a99",
		per_user = false
	},
	{
		type = "int-setting",
		name = "ownlys_tracers--magazine_size",
		setting_type = "startup",
		default_value = 11,
		minimum_value = 1,
		maximum_value = 3000,
		order = "a8",
		per_user = false
	},
	{
		type = "bool-setting",
		name = "ownlys_tracers--mech_armor",
		setting_type = "startup",
		default_value = false,
		order = "a99",
		per_user = false
	},

})
