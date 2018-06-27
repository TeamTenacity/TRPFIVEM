Config = {}
Config.Locale = 'en'

Config.Price = 100

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 25

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.376}, --Strawberry
  {x=-703.776,  y=-152.258,  z=36.425}, --Rockford Hills
  {x=-167.863,  y=-298.969,  z=38.740}, --Burton
  {x=428.694,   y=-800.106,  z=28.491}, --Textile City
  {x=-829.413,  y=-1073.710, z=10.328}, --Vespucci Canals
  {x=-1447.797, y=-242.461,  z=48.830}, --Morningwood
  {x=11.632,    y=6514.224,  z=30.890}, --Paleto Bay
  {x=123.646,   y=-219.440,  z=53.570}, --Alta
  {x=1696.291,  y=4829.312,  z=41.063}, --Grapeseed
  {x=618.093,   y=2759.629,  z=41.088}, --Harmony
  {x=1190.550,  y=2713.441,  z=37.230}, --Route 68
  {x=-1193.429, y=-772.262,  z=16.327}, --Del Perro
  {x=-3172.496, y=1048.133,  z=19.863}, --Chumash
  {x=-1108.441, y=2708.923,  z=18.120}, --Zancudo River
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
