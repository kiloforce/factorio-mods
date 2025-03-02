preset = ""
hsx = require("hsx")

math.round = function(num)
return math.floor(num+0.5)
end

if settings.startup["gore-preset"].value == "blood-red" then
	preset = "red-"
	fx_color = {r=0.9, g=0, b=0.1, a=0.7}
	decal_color = {r=0.7, g=0, b=0.08, a=0.71}
	particle_color = {r=0.5, g=0, b=0.022, a=0.8}
	guts_tint = {r=0.9, g=0.7, b=0.7, a=0.9}
	corpse_tint = nil -- special graphics replacer
elseif settings.startup["gore-preset"].value == "rainbow" then
	preset = "rainbow-"
	fx_color = {r=1, g=1, b=1, a=1}
	decal_color = {r=1, g=1, b=1, a=1}
	--particle_color = {r=0.45, g=0.45, b=0.35, a=0.2}
	particle_color = {r=0.55, g=0.55, b=0.45, a=0.25}
	guts_tint = {r=0.8, g=0.8, b=0.8, a=0.9}
	corpse_tint = {r=0.15, g=1, b=1, a=0.99} -- no special graphics this time
elseif settings.startup["gore-preset"].value == "green" then
	fx_color = {r=0.01, g=0.15, b=0, a=0.88}
	decal_color = {r=0.01, g=0.15, b=0, a=0.7}
	particle_color = {r=0.01, g=0.15, b=0, a=0.7}
	guts_tint = nil
	
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
elseif settings.startup["gore-preset"].value == "purple" then
	fx_color = {r=0.24, g=0.02, b=0.24, a=0.8}
	decal_color = {r=0.16, g=0, b=0.16, a=0.7}
	particle_color = {r=0.24, g=0.02, b=0.24, a=0.7}
	guts_tint = nil
	
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
elseif settings.startup["gore-preset"].value == "puke" then
	fx_color = {r=0.29, g=0.34, b=0.03, a=0.75}
	decal_color = {r=0.22, g=0.26, b=0.03, a=0.7}
	particle_color = {r=0.24, g=0.29, b=0.01, a=0.7}
	guts_tint = nil
	
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
	
elseif settings.startup["gore-preset"].value == "pink" then
	decal_color = {r=0.59, g=0.29, b=0.55, a=0.75}
	local hsv = hsx.rgb2hsv(decal_color)
	
	hsv.v = hsv.v*0.9
	guts_tint = hsx.hsv2rgb(hsv)
	
	hsv.v = hsv.v*0.95
	hsv.s = hsv.s*1.3
	fx_color = hsx.hsv2rgb(hsv)
	
	hsv = hsx.rgb2hsv(decal_color)
	hsv.v = hsv.v*1.5
	hsv.a = 0.7
	particle_color = hsx.hsv2rgb(hsv)
	
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
elseif settings.startup["gore-preset"].value == "custom/automatic" then
	decal_color = settings.startup["gore-decal_color"].value
	local hsv = hsx.rgb2hsv(decal_color)
	
	hsv.v = hsv.v*0.9
	guts_tint = hsx.hsv2rgb(hsv)
	hsv.v = hsv.v*0.9 --
	hsv.s = hsv.s*1.2 --
	fx_color = hsx.hsv2rgb(hsv)
	
	hsv = hsx.rgb2hsv(decal_color)
	hsv.v = hsv.v*1.2
	hsv.a = 0.70
	if hsv.v> 1 then
		hsv.a = hsv.a - 0.05*hsv.v
		hsv.s = math.min(1, hsv.s * hsv.v)
		hsv.v = 1
	end
	particle_color = hsx.hsv2rgb(hsv)
	
	local tint_mult = 1/fx_color.r
	tint_mult = math.min(tint_mult,1/fx_color.g)
	tint_mult = math.min(tint_mult,1/fx_color.b)
	corpse_tint = {r = fx_color.r*tint_mult*0.9, g = fx_color.g*tint_mult*0.9, b = fx_color.b*tint_mult*0.9, a = 1}
	log("automatic fx color: "..math.round(fx_color.r*255).." / "..math.round(fx_color.g*255).." / "..math.round(fx_color.b*255).." / "..math.round(fx_color.a*255))
	log("automatic particle color: "..math.round(particle_color.r*255).." / "..math.round(particle_color.g*255).." / "..math.round(particle_color.b*255).." / "..math.round(particle_color.a*255))
	log("automatic corpse color: "..math.round(corpse_tint.r*255).." / "..math.round(corpse_tint.g*255).." / "..math.round(corpse_tint.b*255).." / "..math.round(corpse_tint.a*255))
	log("automatic guts color: "..math.round(guts_tint.r*255).." / "..math.round(guts_tint.g*255).." / "..math.round(guts_tint.b*255).." / "..math.round(guts_tint.a*255))
	
else
	fx_color = settings.startup["gore-fx_color"].value
	decal_color = settings.startup["gore-decal_color"].value
	particle_color = settings.startup["gore-particle_color"].value
	puddle_d = settings.startup["gore-puddle-d"].value
	corpse_tint = settings.startup["gore-corpse_blood_color"].value
	guts_tint = settings.startup["gore-guts_color"].value
end

