
function gore_blood_puddle(options)
	local ti = table.deepcopy(options.tint or fx_color)
	ti.a = 1
	return{
		sheet =
		{
			filename = "__gore__/graphics/puddle/hr-"..(options.preset or preset).."puddle.png",
			flags = { "low-object" },
			line_length = 4,
			variation_count = 4,
			frame_count = 1,
			width = 164,
			height = 134,
			shift = util.by_pixel(-0.5,-0.5),
			--tint = {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
			tint = ti,
			scale = 0.5 * (options.scale or 1),
		}
	}
end


gore_blood_particle_shadow = function(options)
  local options = options or {}
  options.tint = {r = 0, g = 0, b = 0}
  options.shift = util.by_pixel (1,0)
  options.scale = 0.75
  return
  {
    sheet =
    {
      filename = "__base__/graphics/particle/blood-particle/blood-particle.png",
      line_length = 12,
      width = 32,
      height = 24,
      frame_count = 12,
      variation_count = 7,
      scale = 0.5 * options.scale,
      shift = util.add_shift(util.by_pixel(0,0.5), options.shift),
	  tint = options.tint
    }
  }
end


function gore_blood_particle(options)
  local options = options or {}
  options.scale = 0.75
  return
  {
    sheet =
    {
      filename = "__gore__/graphics/blood-particle/"..options.preset.."blood-particle.png",
      line_length = 12,
      width = 32,
      height = 24,
      frame_count = 12,
      variation_count = 7,
      scale = 0.5 * options.scale,
      shift = util.add_shift(util.by_pixel(0,0.5), options.shift),
	  tint = options.tint
    }
  }
end

function gore_guts_particle(options)
  local options = options or {}
  return
  {
    sheet =
    {
      filename = "__gore__/graphics/guts/"..options.preset.."gut-particles.png",
      priority = "extra-high",
      width = 86,
      height = 90,
      frame_count = 12,
      animation_speed = 0.5,
      variation_count = 10,
      tint = options.tint,
      shift = util.add_shift(util.by_pixel(0,1.0), options.shift),
      scale = 0.35
    }
  }
end