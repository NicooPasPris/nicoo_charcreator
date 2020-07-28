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
TriggerEvent('skinchanger:loadSkin', {sex = 0})
TriggerEvent('nicoo_charcreator:CharCreator')
```


### skinchanger Configuration
In the client file (skinchanger/client/main.lua) at line 199 add this part of code above the function `ApplySkin(skin, clothe)`

```
local Face = {[1] = 'nose_width', [2] = 'nose_peak_hight', [3] = 'nose_peak_lenght', [4] = 'nose_bone_high', [5] = 'nose_peak_lovering', [6] = 'nose_bone_twist', [7] = 'eyebrown_high', [8] = 'eyebrown_forward', [9] = 'cheeks_bone_high', [10] = 'cheeks_bone_width', [11] = 'cheeks_width', [12] = 'eyes_openning', [13] = 'lips_thickness', [14] = 'jaw_bone_width', [15] = 'jaw_bone_back_lenght', [16] = 'chimp_bone_lowering', [17] = 'chimp_bone_lenght', [18] = 'chimp_bone_width', [19] = 'chimp_hole', [20] = 'neck_thickness'}
local HeadOverlay = {[0] = 'blemishes', [1] = 'beard', [2] = 'eyebrows', [3] = 'age', [4] = 'makeup', [5] = 'blush', [6] = 'complexion', [7] = 'sun', [8] = 'lipstick', [9] = 'moles', [10] = 'chest', [11] = 'bodyb'}
RegisterNetEvent('skinchanger:saveWithFiveMFunc')
AddEventHandler('skinchanger:saveWithFiveMFunc', function(index, type, v)
	local playerPed = PlayerPedId()
	if type == 'headoverlay' then
		Character[index..'_1'] = v[1]
		Character[index..'_2'] = v[2]
		if v[3] then
			Character[index..'_3'] = v[3]
		end
		if v[4] then
			Character[index..'_4'] = v[4]
		end
	elseif type == 'componentvariation' then
		if index == 'arms' then
			Character[index] = v[1]
			Character[index..'_2'] = v[2]
		elseif index == 'sex' then
			Character[index] = v[1]
		else
			Character[index..'_1'] = v[1]
			Character[index..'_2'] = v[2]
		end
	elseif type == 'face' then
		Character[index] = v
	elseif type == 'facefeature' then
		Character[Face[index]] = v
	end
end)
```

2. In the `function ApplySkin` modified the line ```SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)```
by
```
  if Character['dad'] and Character['mom'] and Character['shape_mx'] and Character['skin_mx'] then
    	SetPedHeadBlendData(playerPed, Character['dad'], Character['mom'], 0, Character['dad'], Character['mom'], 0, Character['shape_mx'], Character['skin_mx'], 0.0, true)
	else
		SetPedHeadBlendData(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
	end
	for k,v in pairs(Face) do
		SetPedFaceFeature(playerPed, k, Character[v])
	end
```
 ## Nicoo
 And now the script is ready! The installation is a bit complex, that's why I let you contact me if you need help.
 
 # My discord: Nicoo#6134
