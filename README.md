# nicoo_charcreator
Fivem Character Creator

[demo of script](https://www.youtube.com/watch?v=pv_06-KRCCs)

## Requirements

• [skinchanger](https://github.com/esx-framework/skinchanger)

• [esx_skin](https://github.com/esx-framework/esx_skin)

## Installation

1. Install [esx_skin](https://github.com/esx-framework/esx_skin) & [skinchanger](https://github.com/esx-framework/skinchanger)

Note: The nicoo_charcreator script requires a slight modification of the 'skinchanger' script. A 'skinchanger' resource is already configured for you if you wish otherwise, go to [configuration part](https://github.com/NicooPasPris/nicoo_charcreator#configuration)

2. Add in your server.cfg "ensure nicoo_charcreator" (Make sure the resource is started after the 'esx_skin' & 'skinchanger' resources)

3. Configure if you wish the "config.lua" file

## Configuration

### esx_skin Configuration
Edit client file (esx_skin/client/main.lua), replaces line 295 : `TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)`
by 
```
TriggerEvent('nicoo_charcreator:CharCreator')
```


### skinchanger Configuration
In the client file (skinchanger/client/main.lua) at first line, you need to change the `local Components` by

```
local Components = {
	{label = _U('sex'),						name = 'sex',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('face'),					name = 'face',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('skin'),					name = 'skin',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_1'),					name = 'hair_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_2'),					name = 'hair_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_1'),			name = 'hair_color_1',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_2'),			name = 'hair_color_2',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('tshirt_1'),				name = 'tshirt_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 8},
	{label = _U('tshirt_2'),				name = 'tshirt_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'tshirt_1'},
	{label = _U('torso_1'),					name = 'torso_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 11},
	{label = _U('torso_2'),					name = 'torso_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'torso_1'},
	{label = _U('decals_1'),				name = 'decals_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 10},
	{label = _U('decals_2'),				name = 'decals_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'decals_1'},
	{label = _U('arms'),					name = 'arms',				value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('arms_2'),					name = 'arms_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('pants_1'),					name = 'pants_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	componentId	= 4},
	{label = _U('pants_2'),					name = 'pants_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	textureof	= 'pants_1'},
	{label = _U('shoes_1'),					name = 'shoes_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	componentId	= 6},
	{label = _U('shoes_2'),					name = 'shoes_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	textureof	= 'shoes_1'},
	{label = _U('mask_1'),					name = 'mask_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 1},
	{label = _U('mask_2'),					name = 'mask_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'mask_1'},
	{label = _U('bproof_1'),				name = 'bproof_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 9},
	{label = _U('bproof_2'),				name = 'bproof_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bproof_1'},
	{label = _U('chain_1'),					name = 'chain_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 7},
	{label = _U('chain_2'),					name = 'chain_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'chain_1'},
	{label = _U('helmet_1'),				name = 'helmet_1',			value = -1,		min = -1,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 0 },
	{label = _U('helmet_2'),				name = 'helmet_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'helmet_1'},
	{label = _U('glasses_1'),				name = 'glasses_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 1},
	{label = _U('glasses_2'),				name = 'glasses_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'glasses_1'},
	{label = _U('watches_1'),				name = 'watches_1',			value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 6},
	{label = _U('watches_2'),				name = 'watches_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'watches_1'},
	{label = _U('bracelets_1'),				name = 'bracelets_1',		value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 7},
	{label = _U('bracelets_2'),				name = 'bracelets_2',		value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bracelets_1'},
	{label = _U('bag'),						name = 'bags_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 5},
	{label = _U('bag_color'),				name = 'bags_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bags_1'},
	{label = _U('eye_color'),				name = 'eye_color',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_size'),			name = 'eyebrows_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_type'),			name = 'eyebrows_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_1'),			name = 'eyebrows_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_2'),			name = 'eyebrows_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_type'),				name = 'makeup_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_thickness'),		name = 'makeup_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_1'),			name = 'makeup_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_2'),			name = 'makeup_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_type'),			name = 'lipstick_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_thickness'),		name = 'lipstick_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_1'),		name = 'lipstick_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_2'),		name = 'lipstick_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('ear_accessories'),			name = 'ears_1',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.65,	componentId	= 2},
	{label = _U('ear_accessories_color'),	name = 'ears_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65,	textureof	= 'ears_1'},
	{label = _U('chest_hair'),				name = 'chest_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_hair_1'),			name = 'chest_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_color'),				name = 'chest_3',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb'),					name = 'bodyb_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb_size'),				name = 'bodyb_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('wrinkles'),				name = 'age_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('wrinkle_thickness'),		name = 'age_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes'),				name = 'blemishes_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes_size'),			name = 'blemishes_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush'),					name = 'blush_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_1'),					name = 'blush_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_color'),				name = 'blush_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion'),				name = 'complexion_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion_1'),			name = 'complexion_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun'),						name = 'sun_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun_1'),					name = 'sun_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles'),				name = 'moles_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles_1'),				name = 'moles_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_type'),				name = 'beard_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_size'),				name = 'beard_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_1'),			name = 'beard_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_2'),			name = 'beard_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},

	-- Add nicoo_charcreator
	{label = _U('mother_heritage'), 		name = 'mom',				value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('father_heritage'), 		name = 'dad',				value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_width'),	 			name = 'nose_1',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_height'), 			name = 'nose_2',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_peak'), 				name = 'nose_3',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_bone'), 				name = 'nose_4',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_peak_2'), 			name = 'nose_5',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose'), 					name = 'nose_6',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('eyebrows_depth'),			name = 'eyebrows_5',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrows_height'),			name = 'eyebrows_6',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheekbones_height'), 		name = 'cheeks_1',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheekbones_width'),		name = 'cheeks_2',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheek_width'),				name = 'cheeks_3',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('opening_eyes'),			name = 'eye_open',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lips_thick'),				name = 'lips_thick',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('jaw_width'),				name = 'jaw_1',				value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('jaw_length'),				name = 'jaw_2',				value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_height'),				name = 'chin_height',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_lenght'),				name = 'chin_lenght',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_width'),				name = 'chin_width',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_hole'),				name = 'chin_hole',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('neck_thick'),				name = 'neck_thick',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
}
```

2. In the `function ApplySkin` modified the line ```SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)```
by
```
  	SetPedHeadBlendData			(playerPed, Character['mom'], Character['dad'], nil, Character['mom'], Character['dad'], nil, Character['face'], Character['skin'], nil, true)

	local Face = {[0] = 'nose_1', [1] = 'nose_2', [2] = 'nose_3', [3] = 'nose_4', [4] = 'nose_5', [5] = 'nose_6', [6] = 'eyebrows_5', [7] = 'eyebrows_6', [8] = 'cheeks_2', [9] = 'cheeks_1', [10] = 'cheeks_3', [11] = 'eye_open', [12] = 'lips_thick', [13] = 'jaw_1', [14] = 'jaw_2', [15] = 'chin_height', [16] = 'chin_lenght', [17] = 'chin_width', [18] = 'chin_hole', [19] = 'neck_thick'}

	for k,v in pairs(Face) do
		if Character[v] then
			SetPedFaceFeature(GetPlayerPed(-1), k, Character[v])
		end
	end
```
 ## Nicoo
 And now the script is ready! The installation is a bit complex, that's why I let you contact me if you need help.
 
 # My discord: Nicoo#6134
