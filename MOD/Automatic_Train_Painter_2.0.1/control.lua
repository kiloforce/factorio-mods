require('util')
require('color.util')
require('color.database')
require('color.calculator')
require('color.painter')
require('mod_support.exemptions')
--require('mod_support.LTN')

script.on_init(function()
	cache_mods()
	read_custom_colors_table()
end)

script.on_configuration_changed(function()
	cache_mods()
	read_custom_colors_table()
end)

script.on_load(function()
	read_custom_colors_table()
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if(event.setting) == "atp-custom-colors-list" then
		read_custom_colors_table()
	end
end)

script.on_event(defines.events.on_train_changed_state, function(event)
	local train = event.train
	local destination = false

	--retain locomotives set to copy color from destination
	destination = destination_coloring(train, destination)

	--for cargo and fluid wagons only
	disable_destination_coloring(train)

	if destination == true then
		return
	end

	if(train.state == defines.train_state.on_the_path and not train.manual_mode) then

		--mod exemption check
		local exempt = exemption_check(train)
		if exempt == true then
			return
		end

		--LTN check
		--if settings.global["atp-ltn-paint"].value == true then
		--	if storage.mods["LogisticTrainNetwork"] then
		--		local LTN = LTN_check(train)
		--		if LTN == true then
		--			return
		--		end
		--	end
		--end

		--unpaint empty trains
		unpaint_empty(train)
		unpaint_wagons(train)

		--train content reader/counter
		local cargo_content = name_count_extractor(train.get_contents())
		local fluid_content = normalize(train.get_fluid_contents(), 10)
		local all_train_content = tableMerge(cargo_content, fluid_content)

		--color mixing calculator
		local final_color, flag = color_calculator(all_train_content, colors, custom_colors)

		--check if mixed_colors were initialized
		if flag == false then
			return
		end

		--paint locomotives
		paint_locomotive(train, 'front_movers', final_color)
		paint_locomotive(train, 'back_movers', final_color)

		--paint cargo wagons
		paint_wagons(train.cargo_wagons, 'paint-cargo-wagon', default_color("u-cargo-wagon"), final_color)
		paint_wagons(train.fluid_wagons, 'paint-fluid-wagon', default_color("u-fluid-wagon"), final_color)
	end
end)