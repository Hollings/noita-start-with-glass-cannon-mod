dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/perks/perk_list.lua" )

function OnPlayerSpawned( player_entity )
	if tonumber(StatsGetValue("playtime")) > 1 then
		return
	end

	local perk_data = perk_list[19]
	local perk_id = perk_data.id
	local flag_name = get_perk_picked_flag_name(perk_id)
	GameAddFlagRun( flag_name )
	if perk_data.game_effect ~= nil then
		local game_effect_comp = GetGameEffectLoadTo( player_entity, perk_data.game_effect, true )
		if game_effect_comp ~= nil then
			ComponentSetValue( game_effect_comp, "frames", "-1" )
		end
	end
	if perk_data.func ~= nil then
		perk_data.func( nil, player_entity, nil )
	end
	local entity_ui = EntityCreateNew( "" )
	EntityAddComponent( entity_ui, "UIIconComponent",
	{
		name = perk_data.ui_name,
		description = perk_data.ui_description,
		icon_sprite_file = perk_data.ui_icon
	})
	EntityAddChild( player_entity, entity_ui )
	GamePrintImportant( GameTextGet( "$log_pickedup_perk", GameTextGetTranslatedOrNot( perk_data.ui_name ) ), perk_data.ui_description )
end
