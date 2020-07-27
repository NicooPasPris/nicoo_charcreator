#Requirements#

• skinchanger
• esx_skin

#Installation#

1. Avoir 'esx_skin' & 'skinchanger' d'installer
Note: Le script nicoo_charcreator exige une légère modification du script 'skinchanger'. Une ressource 'skinchanger', est déjà configuré pour vous si vous le souhaitez sinon, allez dans la rubrique #Configuration#

2. Ajout dans votre serveur.cfg "ensure nicoo_charcreator" (Veilliez à ce que la ressource soit bien start après les resources 'esx_skin' & 'skinchanger')
3. Configurer si vous le souhaitez le fichier "config.lua"

#Configuration#

• Configurer l'esx_skin :

Modifier le fichier client (esx_skin/client/main.lua) remplace la ligne 295
`TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)`
par
`TriggerEvent('nicoo_charcreator:CharCreator')`

• Config skinchanger : 

1. Ajoutez ce morceau de code au dessus de `function ApplySkin(skin, clothes)` (skinchanger/client/main.lua - ligne 199)
`
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
`

2. Dans la fonction ApplySkin modifié la ligne 
`SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)`
par
`	if Character['dad'] and Character['mom'] and Character['shape_mx'] and Character['skin_mx'] then
    	SetPedHeadBlendData(playerPed, Character['dad'], Character['mom'], 0, Character['dad'], Character['mom'], 0, Character['shape_mx'], Character['skin_mx'], 0.0, true)
	else
		SetPedHeadBlendData(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
	end
	for k,v in pairs(Face) do
		SetPedFaceFeature(playerPed, k, Character[v])
	end` 

#Nicoo#
Et voilà le script est prêt ! L'installation est un peu complexe, c'est pour ça que je vous laisse me contacter si vous avez besoin d'aide.
Mon discord: Nicoo#6134