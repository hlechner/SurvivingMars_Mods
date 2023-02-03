-- See LICENSE for terms

local mod = CurrentModDef

local logos = {
	{
		file = "Aer_Lingus",
		name = "Aer Lingus",
	},
	{
		file = "Air_Canada",
		name = "Air Canada",
	},
	{
		file = "Air_France",
		name = "Air France",
	},
	{
		file = "Air_New_Zealand",
		name = "Air New Zealand",
	},
	{
		file = "Alaska",
		name = "Alaska",
	},
	{
		file = "American",
		name = "American",
	},
	{
		file = "Avianca",
		name = "Avianca",
	},
	{
		file = "Azul",
		name = "Azul",
	},
	{
		file = "China_Southern",
		name = "China Southern",
	},
	{
		file = "Delta",
		name = "Delta",
	},
	{
		file = "Edelweiss",
		name = "Edelweiss",
	},
	{
		file = "Emirates",
		name = "Emirates",
	},
	{
		file = "Hawaiian",
		name = "Hawaiian",
	},
	{
		file = "JAL",
		name = "JAL",
	},
	{
		file = "KLM",
		name = "KLM",
	},
	{
		file = "Latam",
		name = "Latam",
	},
	{
		file = "Lufthansa",
		name = "Lufthansa",
	},
	{
		file = "Oceanic",
		name = "Oceanic",
	},
	{
		file = "Pan_Am",
		name = "Pan Am",
	},
	{
		file = "Qantas",
		name = "Qantas",
	},
	{
		file = "Qatar",
		name = "Qatar",
	},
	{
		file = "Thai",
		name = "Thai",
	},
	{
		file = "Turkish",
		name = "Turkish",
	},
	{
		file = "United",
		name = "United",
	},
	{
		file = "Varig",
		name = "Varig",
	},
	{
		file = "Vietnam",
		name = "Vietnam",
	},
}
local logos_length = #logos

do -- LoadEntity
	-- no sense in making a new one for each entity
	local entity_template_decal = {
		category_Decors = true,
		entity = {
			fade_category = "Never",
			material_type = "Metal",
		},
	}

	-- local instead of global is quicker
	local EntityData = EntityData
	local EntityLoadEntities = EntityLoadEntities
	local SetEntityFadeDistances = SetEntityFadeDistances
	local ent_path = mod.env.CurrentModPath .. "Entities/"

	for i = 1, logos_length do
		local file = logos[i].file

		EntityData[file] = entity_template_decal
		EntityLoadEntities[#EntityLoadEntities + 1] = {
			mod,
			file,
			ent_path .. file .. ".ent"
		}
		SetEntityFadeDistances(file, -1, -1)
	end
end -- LoadEntity

do -- Postprocess
	local PlaceObj = PlaceObj
	local logo_path = mod.env.CurrentModPath .. "UI/"

	function OnMsg.ClassesPostprocess()
		for i = 1, logos_length do
			local logo = logos[i]
			local file = logo.file

			local id = "AirlineLogos_" .. file
			if not MissionLogoPresetMap[id] then
				PlaceObj("MissionLogoPreset", {
					decal_entity = file,
					entity_name = file,
					display_name = "Airline: " .. logo.name,
					id = id,
					image = logo_path .. file .. ".png",
				})
			end
		end
	end
end -- Postprocess
