if VisualTracerAnimDef then
	return VisualTracerAnimDef
end
local VisualTracerAnim = {}

function VisualTracerAnim.clamp (val, min, max)
	return math.min(
		math.max(val, min),
		max
	)
end

function VisualTracerAnim.lerp (a, b, t)
	t = VisualTracerAnim.clamp(t, 0, 1)
	return a * (1 - t) + b * t
end

function VisualTracerAnim.generate (scaleA, tintA, scaleB, tintB, count)
	if count <= 0 then
		return {}
	end
	
	local animSet = {}
	count = math.max(count - 1, 1)
	for i = 0, count do
		local t = i / count
		local scale = VisualTracerAnim.lerp(scaleA, scaleB, t)*settings.startup["ownlys_tracers--scale"].value
		local tint = {
			r = VisualTracerAnim.lerp(tintA.r, tintB.r, t),
			g = VisualTracerAnim.lerp(tintA.g, tintB.g, t),
			b = VisualTracerAnim.lerp(tintA.b, tintB.b, t),
			a = VisualTracerAnim.lerp(tintA.a, tintB.a, t),
		}

		table.insert(animSet,
		{
			filename = "__ownlys_tracers__/graphics/entities/tracer.png",
			scale = scale,
			tint = tint,
			width = 3,
			height = 75,
			priority = "extra-high",
			draw_as_glow = true,
		})
	end

	return animSet
end

VisualTracerAnimDef = VisualTracerAnim
return VisualTracerAnim
