petrolCanPrice = 100

lang = "en"
-- lang = "fr"

settings = {}
settings["en"] = {
	openMenu = "Press ~INPUT_CONTEXT~ to buy ~g~Fuel~s~",
	electricError = "~r~You have an electric vehicle.",
	fuelError = "~r~Can't fuel here.",
	buyFuel = "Buy Fuel",
	liters = "Gallons",
	percent = "percent",
	confirm = "Confirm",
	fuelStation = "Fuel Station",
	boatFuelStation = "Fuel Station | Boat",
	avionFuelStation = "Fuel Station | Plane ",
	heliFuelStation = "Fuel Station | Helicopter",
	getJerryCan = "Press ~INPUT_CONTEXT~ to buy a ~b~Jerry Can~s~ (~g~$"..petrolCanPrice.."~s~)",
	refeel = "Press ~INPUT_CONTEXT~ to refuel the car.",
	YouHaveBought = "You have bought ",
	fuel = " gallons of gasoline",
	price = "price"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice.."$)",
	refeel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	YouHaveBought = "Vous avez acheté ",
	fuel = " litres d'essence",
	price = "prix"
}


showBar = true
showText = true


hud_form = 2 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.2169 
hud_y = 0.975

text_y = 0.912
text_x = 0.2210


electricityPrice = 1 -- NOT RANOMED !!

randomPrice = false --Random the price of each stations
price = 2 --If random price is on False, set the price here for 1 liter