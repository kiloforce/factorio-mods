data:extend({
  {
  	type = "technology",
  	name = "cathodes",
    icon = "__NixieTubesThreeDigits__/graphics/nixie-technology-icon.png",
    icon_size = 226,
  	unit = {
  		count=20,
      time=10,
      ingredients = {
          {"automation-science-pack", 1,},
          {"logistic-science-pack", 1,},
        },
    },
    prerequisites = {"advanced-electronics"},
    effects = {
      {
        type = "unlock-recipe",
        recipe = "nixie-tube",
      },
      {
        type = "unlock-recipe",
        recipe = "nixie-tube-alpha",
      },
      {
        type = "unlock-recipe",
        recipe = "nixie-tube-small",
      },
	  {
        type = "unlock-recipe",
        recipe = "nixie-tube-triplet",
      },
    },
    order = "a-d-e",
  },
})
