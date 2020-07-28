Config = {}

-- Language du menu
-- Menu language
Config.Locale = 'fr'

-- Location du spawn joueur après la création du personnage
-- Rental of player spawn after character creation
Config.PlayerSpawn = {x = -1042.635, y =-2745.828, z = 21.359, h = -30.0}

-- Il faut a maximum 23 nom pour le père & 21 nom pour la mère
-- You need a maximum of 23 name for the father & 21 name for the mother
Config.FatherNamesList = {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Claude", "Niko", "John"}
Config.MotherNamesList = {"Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma", "Misty"}

-- Liste des tenues
-- List of outfits
Config.Tenue = {
	{
		label = 'Vagos',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {14, 1},
				decals = {0, 0},
				arms = {1, 0},
				pants = {42, 5},
				shoes = {8, 6},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {0, 0},
				torso = {0, 0},
				decals = {0, 0},
				arms = {1, 0},
				pants = {0, 0},
				shoes = {0, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},

	{
		label = 'Families',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {128, 0},
				decals = {0, 0},
				arms = {0, 0},
				pants = {42, 6},
				shoes = {6, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {0, 0},
				torso = {0, 0},
				decals = {0, 0},
				arms = {1, 0},
				pants = {0, 0},
				shoes = {0, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},

	{
		label = 'Habillé pour un entretient',
		id = {
			male = {
				tshirt = {26, 0},
				torso = {60, 2},
				decals = {0, 0},
				arms = {0, 0},
				pants = {27, 3},
				shoes = {66, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {0, 0},
				torso = {0, 0},
				decals = {0, 0},
				arms = {1, 0},
				pants = {0, 0},
				shoes = {0, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},

	{
		label = 'Chic',
		id = {
			male = {
				tshirt = {75, 0},
				torso = {72, 0},
				decals = {0, 0},
				arms = {2, 0},
				pants = {24, 0},
				shoes = {40, 9},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {0, 0},
				torso = {0, 0},
				decals = {0, 0},
				arms = {1, 0},
				pants = {0, 0},
				shoes = {0, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},
}
