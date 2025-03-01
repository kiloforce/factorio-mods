local mask = data.raw.locomotive["locomotive"].pictures.layers[2]
for i = 1, 8 do
	mask.filenames[i] = "__vibrant-trains__/sprites/diesel-locomotive-mask-0"..i..".png"
end
for i = 1, 16 do
	mask.hr_version.filenames[i] = "__vibrant-trains__/sprites/hr-diesel-locomotive-mask-"..i..".png"
end
