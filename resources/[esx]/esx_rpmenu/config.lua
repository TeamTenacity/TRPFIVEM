Config = {}

Config.Animations = {

	{
		name  = 'work',
		label = 'Job Emotes',
		items = {
		{label = "Police: Idle", type = "scenario", data = {anim = "WORLD_HUMAN_COP_IDLES"}},
		{label = "Police: Guard", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND"}},
	    {label = "Police: Investigate", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
	    {label = "Police: Direct Traffic", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
	    {label = "Police: Bionoculars", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
	    {label = "Polic: Clipboard", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
	    {label = "Police: Notebook", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"}},
	    {label = "Police: Crowd Control", type = "scenario", data = {anim = "CODE_HUMAN_POLICE_CROWD_CONTROL"}},
	    {label = "Fisherman: Fish", type = "scenario", data = {anim = "world_human_stand_fishing"}},
	    {label = "Gardener: Plant", type = "scenario", data = {anim = "world_human_gardener_plant"}},
	    {label = "Gardener: Leafblow", type = "scenario", data = {anim = "WORLD_HUMAN_GARDENER_LEAF_BLOWER"}},
	    {label = "Mechanic: Work Under Car", type = "scenario", data = {anim = "world_human_vehicle_mechanic"}},
	    {label = "Mechanic: Fix Engine", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
	    {label = "Mechanic: Weld", type = "scenario", data = {anim = "WORLD_HUMAN_WELDING"}},
	    {label = "EMS: Kneel", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
	    {label = "Taxi: Speak to Client in Backseat", type = "anim1", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
	    {label = "Taxi: Recieve Payment", type = "anim1", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
	    {label = "Grocer: Take out Case", type = "anim1", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
	    {label = "Bartender: Serve a Shot", type = "anim1", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
	    {label = "Reporter: Take Pictures w/ Camera", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
	    {label = "Construction: Hammer", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Greetings',
		items = {
	    {label = "Wave Hi", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
	    {label = "Handshake", type = "anim1", data = {lib = "mp_common", anim = "givetake1_a"}},
	    {label = "Secret Handshake", type = "anim1", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
	    {label = "Bro Hug", type = "anim1", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
	    {label = "Salute", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'humors',
		label = 'Interactions',
		items = {
	    {label = "Clapping", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
	    {label = "Two Thumbs Up", type = "anim1", data = {lib = "mp_action", anim = "thanks_male_06"}},
	    {label = "You", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
	    {label = "C'mon", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}},
	    {label = "No", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_no_way"}},
	    {label = "You got a problem?", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
	    {label = "Me", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
	    {label = "Facepalm", type = "anim1", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
	    {label = "Calm Down ", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
	    {label = "What is that?", type = "anim1", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
	    {label = "Cower", type = "anim1", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
	    {label = "Bring it on", type = "anim1", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
	    {label = "Damn.", type = "anim1", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
	    {label = "Double Birds", type = "anim1", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
	    {label = "Wank", type = "anim1", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
	    {label = "Suicide", type = "anim1", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'festives',
		label = 'Party',
		items = {
	    {label = "Musician", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
	    {label = "DJ", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
	    {label = "Dance", type = "anim", data = {lib = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler"}},
	    {label = "Drink a 40oz", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
	    {label = "Drink a Beer", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
	    {label = "Air Guitar", type = "anim1", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
	    {label = "Air Shagging", type = "anim1", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
	    {label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
	    {label = "Smoke a Joint", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
	    {label = "Drunk Staggering", type = "anim1", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
		}
	},

	{
		name  = 'sports',
		label = 'Workout',
		items = {
	    {label = "Flex", type = "scenario", data = {anim = "WORLD_HUMAN_MUSCLE_FLEX"}},
	    {label = "Lift Weights", type = "scenario", data = {anim = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"}},
	    {label = "Push Ups", type = "scenario", data = {anim = "WORLD_HUMAN_PUSH_UPS"}},
	    {label = "Sit Ups", type = "scenario", data = {anim = "WORLD_HUMAN_SIT_UPS"}},
	    {label = "Yoga", type = "scenario", data = {anim = "WORLD_HUMAN_YOGA"}},
	    {label = "Jogging", type = "scenario", data = {anim = "WORLD_HUMAN_JOG_STANDING"}},
		}
	},

	{
		name  = 'misc',
		label = 'Miscellaneous',
		items = {
	    {label = "Drink Coffee", type = "scenario", data = {anim = "WORLD_HUMAN_AA_COFFEE"}},
		{label = "Sit on the Ground", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
	    {label = "Lean", type = "scenario", data = {anim = "world_human_leaning"}},
	    {label = "Lie on Back", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
	    {label = "Lie on Chest", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
	    {label = "Clean", type = "scenario", data = {anim = "world_human_maid_clean"}},
	    {label = "Grill", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
	    {label = "Take a Selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
	    {label = "Listen", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
	    {label = "Beg w/ Sign", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
	    {label = "Human Statue", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
	    {label = "Look At Map", type = "scenario", data = {anim = "WORLD_HUMAN_TOURIST_MAP"}},
	    {label = "Use Phone", type = "scenario", data = {anim = "WORLD_HUMAN_STAND_MOBILE"}},
		}
	},

	{
		name  = 'attitudem',
		label = 'Walk Styles',
		items = {
	    {label = "Normal - M", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
	    {label = "Normal - F", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
	    {label = "Sad - M", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
	    {label = "Sad - F", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
	    {label = "Business", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
	    {label = "Threatening", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
	    {label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
	    {label = "Fat", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
	    {label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
	    {label = "Limping", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
	    {label = "Intimidated", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
	    {label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
	    {label = "Mourning", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
	    {label = "Muscle", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
	    {label = "Shocked", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
	    {label = "Shady", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
	    {label = "Tipsy", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
	    {label = "Rich", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
	    {label = "Speed Walking", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
	    {label = "Jell-O", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
	    {label = "Sassy", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
	    {label = "Arrogant", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},

}