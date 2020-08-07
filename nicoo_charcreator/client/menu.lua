-- Menu
mainMenu = RageUI.CreateMenu(Locales[Config.Locale]['main_title'], Locales[Config.Locale]['main_subtitle'])
heritage = RageUI.CreateSubMenu(mainMenu, Locales[Config.Locale]['heritage_title'], Locales[Config.Locale]['heritage_subtitle'])
visage = RageUI.CreateSubMenu(mainMenu, Locales[Config.Locale]['visage_title'], Locales[Config.Locale]['visage_subtitle'])
apperance = RageUI.CreateSubMenu(mainMenu, Locales[Config.Locale]['apperance_title'], Locales[Config.Locale]['apperance_subtitle'])
visage.EnableMouse = true;
apperance.EnableMouse = true;
mainMenu.Controls.Back.Enabled = false

heritage.Closed = function()
	CreateSkinCam('body')
end

visage.Closed = function()
	CreateSkinCam('body')
end

apperance.Closed = function()
	CreateSkinCam('body')
end


-- Panel
Panel = {
	GridPanel = {
		x = 0.5,
		y = 0.5,
		Top = Locales[Config.Locale]['top'],
        Bottom = Locales[Config.Locale]['bottom'],
        Left = Locales[Config.Locale]['left'],
        Right = Locales[Config.Locale]['right'],
		enable = false
	},

	GridPanelHorizontal = {
		x = 0.5,
        Left = Locales[Config.Locale]['left'],
        Right = Locales[Config.Locale]['right'],
		enable = false
	},

	ColourPanel = {
		itemIndex = 1,
        index_one = 1,
        index_two = 1,
		name = Locales[Config.Locale]['colour'],
        Color = RageUI.PanelColour.HairCut,
		enable = false
	},

	PercentagePanel = {
		index = 0,
        itemIndex = 1,
        MinText = '0%',
        HeaderText = Locales[Config.Locale]['opacity'],
        MaxText = '100%',
		enable = false
	}


}

function ManagePanel(type, data)
    if data.Top then
    	Panel[type].Top = data.Top
    end

    if data.Bottom then
    	Panel[type].Bottom = data.Bottom
    end

    if data.Left then
    	Panel[type].Left = data.Left
    end

    if data.Right then
    	Panel[type].Right = data.Right
    end

    if data.x then
    	Panel[type].PFF = data.x
    end

    if data.y then
    	Panel[type].PFF2 = data.y
    end

    if type ~= 'ColourPanel' and type ~= 'PercentagePanel' and type ~= '' then

	    if not Panel[type].currentItem then
	        Panel[type].lastItem = data.x[2]
		else
			Panel[type].lastItem = Panel[type].currentItem
		end	
		Panel[type].currentItem = data.x[2]
		if not Panel[type][Panel[type].currentItem] then
			Panel[type][Panel[type].currentItem] = {
				x = 0.5,
				y = 0.5
			}
		end
	end

	if type == 'ColourPanel' or type == 'PercentagePanel' then

		Panel[type].itemIndex = data.index
		if data.Panel then
			Panel[data.Panel].itemIndex = data.index
		end

		if not Panel[type].currentItem then
	        Panel[type].lastItem = data.item
		else
			Panel[type].lastItem = Panel[type].currentItem
		end	
		Panel[type].currentItem = data.item

		if not Panel[type][Panel[type].currentItem] then
			Panel[type][Panel[type].currentItem] = {
				index = type == 'ColourPanel' and 1 or 0,
				minindex = 1
			}
		end

		if data.Panel then
			if not Panel[data.Panel].currentItem then
		        Panel[data.Panel].lastItem = data.item
			else
				Panel[data.Panel].lastItem = Panel[data.Panel].currentItem
			end	
			Panel[data.Panel].currentItem = data.item

			if not Panel[data.Panel][Panel[data.Panel].currentItem] then
				Panel[data.Panel][Panel[data.Panel].currentItem] = {
					index = data.Panel == 'PercentagePanel' and 0 or 1,
					minindex = 1
				}
			end
		end
	end

	for k,v in pairs(Panel) do
		if data.Panel then
			if k == type or k == data.Panel then
				v.enable = true
			else
				v.enable = false
			end
		else
	        if k == type then
	            v.enable = true
	        else
	            v.enable = false
	        end
	    end
    end
end

-- Item
local actionGender, actionClothe, actionMother, actionFather, actionRessemblance, actionSkin = 1, 1, 1, 1, 5, 5
local CharacterMom, CharacterDad, ShapeMixData, SkinMixData = 1, 1, 0.5, 0.5
local amount = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 };
RageUI.CreateWhile(1.0, mainMenu, nil, function()

	-- Main Menu
	RageUI.IsVisible(mainMenu, true, true, true, function()

		mainMenu.Controls.Back.Enabled = false
		-- Sexe
        RageUI.List(Locales[Config.Locale]['gender_item'], {Locales[Config.Locale]['gender_male'], Locales[Config.Locale]['gender_female']}, actionGender, Locales[Config.Locale]['gender_item_desc'], {}, true, function(Hovered, Active, Selected, Index)
		end, function(Index, Item)
			actionGender = Index
			changeGender(Index)
		end)

		-- Héritage
		RageUI.Button(Locales[Config.Locale]['heritage_item'], Locales[Config.Locale]['heritage_item_desc'], {RightBadge = 17}, true, function(Hovered, Active, Selected)
			if Selected then
				CreateSkinCam('face')
				heritage.Controls.Back.Enabled = true
			end
		end, heritage)

		-- Visage
		RageUI.Button(Locales[Config.Locale]['visage_item'], Locales[Config.Locale]['visage_item_desc'],{RightBadge = 16}, true, function(Hovered, Active, Selected)
			if Selected then
				CreateSkinCam('face')
				visage.Controls.Back.Enabled = true
			end
		end, visage)

		-- Apparence
		RageUI.Button(Locales[Config.Locale]['apperance_item'], Locales[Config.Locale]['apperance_item_desc'],{RightBadge = 9}, true, function(Hovered, Active, Selected)
			if Selected then
				CreateSkinCam('face')
				apperance.Controls.Back.Enabled = true
			end
		end, apperance)

		-- Clothe
		RageUI.List(Locales[Config.Locale]['clothe_item'], ClotheList, actionClothe, Locales[Config.Locale]['clothe_item_desc'], {}, true, function(Hovered, Active, Selected, Index)
		end, function(Index, Item) 
			actionClothe = Index
			updateClothe(actionClothe)
		end)

		RageUI.Button('', false,{}, true, function(Hovered, Active, Selected)
		end)

		RageUI.Button(Locales[Config.Locale]['confirm_item'], Locales[Config.Locale]['confirm_item_desc'], {RightBadge = 23, Color = {BackgroundColor = RageUI.ItemsColour.Gang1}}, true, function(Hovered, Active, Selected)
			if Selected then
				RageUI.CloseAll()
				EndCharCreator()
			end
		end)
	end, function() end)

	-- Heritage Menu
	RageUI.IsVisible(heritage, true, true, true, function()
		RageUI.HeritageWindow(CharacterMom, CharacterDad)

		RageUI.List(Locales[Config.Locale]['heritage_mother_item'], Config.MotherList, actionMother, Locales[Config.Locale]['heritage_mother_item_desc'], {}, true, function(hovered,active,selected, Index)
        end, function(Index, Item)
        	actionMother = Index
        	CharacterMom = Index
        	Character['mom'] = Index
			SetPedHeadBlendData(GetPlayerPed(-1), CharacterMom, CharacterDad, nil, CharacterMom, CharacterDad, nil, ShapeMixData, SkinMixData, nil, true)
        end)

        RageUI.List(Locales[Config.Locale]['heritage_father_item'], Config.FatherList, actionFather, Locales[Config.Locale]['heritage_father_item_desc'], {}, true, function(hovered,active,selected, Index)
        end, function(Index, Item)
        	actionFather = Index
        	CharacterDad = Index
        	Character['dad'] = Index
			SetPedHeadBlendData(GetPlayerPed(-1), CharacterMom, CharacterDad, nil, CharacterMom, CharacterDad, nil, ShapeMixData, SkinMixData, nil, true)
        end)

        RageUI.UISliderHeritage(Locales[Config.Locale]['resemblance_item'], actionRessemblance, Locales[Config.Locale]['resemblance_item_desc'], function(Hovered, Selected, Active, Heritage, Index)
        	if Selected then
        		actionRessemblance = Index
        		ShapeMixData = Index/10
        		Character['face'] = Index/10
				SetPedHeadBlendData(GetPlayerPed(-1), CharacterMom, CharacterDad, nil, CharacterMom, CharacterDad, nil, ShapeMixData, SkinMixData, nil, true)
        	end
        end, amount)

        RageUI.UISliderHeritage(Locales[Config.Locale]['skin_item'], actionSkin, Locales[Config.Locale]['skin_item_desc'], function(Hovered, Selected, Active, Heritage, Index)
        	if Selected then
        		actionSkin = Index
        		SkinMixData = Index/10
        		Character['skin'] = Index/10
				SetPedHeadBlendData(GetPlayerPed(-1), CharacterMom, CharacterDad, nil, CharacterMom, CharacterDad, nil, ShapeMixData, SkinMixData, nil, true)
        	end
        end, amount)
	end, function() end)

	-- Visage Menu
	RageUI.IsVisible(visage, true, true, true, function()
		RageUI.Button(Locales[Config.Locale]['nose'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanel', {x = {0, 'nose_1'}, y = {1, 'nose_2'}, Top = Locales[Config.Locale]['top'], Bottom = Locales[Config.Locale]['bottom'], Left = Locales[Config.Locale]['narrow'], Right = Locales[Config.Locale]['large']})
			end
    	end)

        RageUI.Button(Locales[Config.Locale]['profil_nose'], false, {}, true, function(Hovered, Active, Selected)
        	if Active then
				ManagePanel('GridPanel', {x = {2, 'nose_3'}, y = {3, 'nose_4'}, Top = Locales[Config.Locale]['curve'], Bottom = Locales[Config.Locale]['curved'], Left = Locales[Config.Locale]['short'], Right = Locales[Config.Locale]['long']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['pointe_nose'], false, {}, true, function(Hovered, Active, Selected)
        	if Active then
				ManagePanel('GridPanel', {x = {4, 'nose_5'}, y = {5, 'nose_6'}, Top = Locales[Config.Locale]['broke_left'], Bottom = Locales[Config.Locale]['broke_right'], Left = Locales[Config.Locale]['peak_high'], Right = Locales[Config.Locale]['peak_low']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['eyebrows'], false, {}, true, function(Hovered, Active, Selected)
        	if Active then
				ManagePanel('GridPanel', {x = {6, 'eyebrows_5'}, y = {7, 'eyebrows_6'}, Top = Locales[Config.Locale]['top'], Bottom = Locales[Config.Locale]['bottom'], Left = Locales[Config.Locale]['outside'], Right = Locales[Config.Locale]['interior']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['cheekbones'], false, {}, true, function(Hovered, Active, Selected)
        	if Active then
				ManagePanel('GridPanel', {x = {9, 'cheeks_1'}, y = {8, 'cheeks_2'}, Top = Locales[Config.Locale]['top'], Bottom = Locales[Config.Locale]['bottom'], Left = Locales[Config.Locale]['dig'], Right = Locales[Config.Locale]['inflate']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['cheek'], false, {}, true, function(Hovered, Active, Selected)
        	if Active then
				ManagePanel('GridPanelHorizontal', {x = {10, 'cheeks_3'}, Left = Locales[Config.Locale]['inflate'], Right = Locales[Config.Locale]['dig']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['eyes'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanelHorizontal', {x = {11, 'eye_open'}, Left = Locales[Config.Locale]['opened_eyes'], Right = Locales[Config.Locale]['narrowed_eyes']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['lips'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanelHorizontal', {x = {12, 'lips_thick'}, Left = Locales[Config.Locale]['thick'], Right = Locales[Config.Locale]['thin']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['jaw'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanel', {x = {13, 'jaw_1'}, y = {14, 'jaw_2'}, Top = Locales[Config.Locale]['round'], Bottom = Locales[Config.Locale]['square'], Left = Locales[Config.Locale]['narrow'], Right = Locales[Config.Locale]['large']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['chin'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanel', {x = {15, 'chin_height'}, y = {16, 'chin_lenght'}, Top = Locales[Config.Locale]['top'], Bottom = Locales[Config.Locale]['bottom'], Left = Locales[Config.Locale]['deep'], Right = Locales[Config.Locale]['outside']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['shape_chin'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanel', {x = {17, 'chin_width'}, y = {18, 'chin_hole'}, Top = Locales[Config.Locale]['sharp'], Bottom = Locales[Config.Locale]['bum'], Left = Locales[Config.Locale]['round'], Right = Locales[Config.Locale]['square']})
			end
        end)

        RageUI.Button(Locales[Config.Locale]['neck_thickness'], false, {}, true, function(Hovered, Active, Selected)
			if Active then
				ManagePanel('GridPanelHorizontal', {x = {19, 'neck_thick'}, Left = Locales[Config.Locale]['thin'], Right = Locales[Config.Locale]['thick']})
			end
        end)
	end, function() 
		if Panel.GridPanel.enable then
			RageUI.GridPanel(Panel.GridPanel.x, Panel.GridPanel.y, Panel.GridPanel.Top, Panel.GridPanel.Bottom, Panel.GridPanel.Left, Panel.GridPanel.Right, function(Hovered, Active, X, Y)
	        	if Panel.GridPanel.lastItem == Panel.GridPanel.currentItem then
      				Panel.GridPanel.x = X
	        		Panel.GridPanel.y = Y
      			else
      				Panel.GridPanel.x = Panel.GridPanel[Panel.GridPanel.currentItem].x
      				Panel.GridPanel.y = Panel.GridPanel[Panel.GridPanel.currentItem].y
      			end


	        	if Active then
      				Panel.GridPanel[Panel.GridPanel.currentItem].x = X
      				Panel.GridPanel[Panel.GridPanel.currentItem].y = Y

		        	SetPedFaceFeature(GetPlayerPed(-1), Panel.GridPanel.PFF[1], X)
		        	SetPedFaceFeature(GetPlayerPed(-1), Panel.GridPanel.PFF2[1], Y)

		        	Character[Panel.GridPanel.PFF[2]] = X
		        	Character[Panel.GridPanel.PFF2[2]] = Y
		        end
	        end)
	    end

	    if Panel.GridPanelHorizontal.enable then
      		RageUI.GridPanelHorizontal(Panel.GridPanelHorizontal.x, Panel.GridPanelHorizontal.Left, Panel.GridPanelHorizontal.Right, function(Hovered, Active, X)
      			if Panel.GridPanelHorizontal.lastItem == Panel.GridPanelHorizontal.currentItem then
      				Panel.GridPanelHorizontal.x = X
      			else
      				Panel.GridPanelHorizontal.x = Panel.GridPanelHorizontal[Panel.GridPanelHorizontal.currentItem].x
      			end
      			if Active then
      				Panel.GridPanelHorizontal[Panel.GridPanelHorizontal.currentItem].x = X
	      			SetPedFaceFeature(GetPlayerPed(-1), Panel.GridPanelHorizontal.PFF[1], X)
	      			Character[Panel.GridPanelHorizontal.PFF[2]] = X
	      		end
      		end)
	    end
	end)

	-- Apparence Menu
	RageUI.IsVisible(apperance, true, true,  true, function()
		for k,v in ipairs(Apperance) do
			RageUI.List(Locales[Config.Locale][v.item], v.List, v.index, Locales[Config.Locale][v.item..'_desc'], {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					if v.ColourPanel and v.PercentagePanel then
						ManagePanel('ColourPanel', {Panel = 'PercentagePanel', index = k, item = v.item})
					elseif v.ColourPanel and not v.PercentagePanel then
						ManagePanel('ColourPanel', {index = k, item = v.item})
					elseif not v.ColourPanel and v.PercentagePanel then
						ManagePanel('PercentagePanel', {index = k, item = v.item})
					elseif not v.ColourPanel and not v.PercentagePanel then
						ManagePanel('', {})
					end

					if v.cam ~= lastCam then
                        lastCam = v.cam
                        CreateSkinCam(v.cam)
                    end
                end
            end, function(Index, Item)
                v.index = Index
                updateApperance(k)
            end)
		end
	end, function()
		if Panel.ColourPanel.enable then
			RageUI.ColourPanel(Panel.ColourPanel.name, Panel.ColourPanel.Color, Panel.ColourPanel.index_one, Panel.ColourPanel.index_two, function(Hovered, Active, MinimumIndex, CurrentIndex)
				if Panel.ColourPanel.lastItem == Panel.ColourPanel.currentItem then
					Panel.ColourPanel.index_one = MinimumIndex
					Panel.ColourPanel.index_two = CurrentIndex
				else
					Panel.ColourPanel.index_one = Panel.ColourPanel[Panel.ColourPanel.currentItem].minindex
					Panel.ColourPanel.index_two = Panel.ColourPanel[Panel.ColourPanel.currentItem].index
				end

				if Active then
					Panel.ColourPanel[Panel.ColourPanel.currentItem].minindex = MinimumIndex
					Panel.ColourPanel[Panel.ColourPanel.currentItem].index = CurrentIndex

					Apperance[Panel.ColourPanel.itemIndex].indextwo = math.floor(CurrentIndex+0.0)
					updateApperance(Panel.ColourPanel.itemIndex, true, false)
				end
			end)
		end

		if Panel.PercentagePanel.enable then
			RageUI.PercentagePanel(Panel.PercentagePanel.index, Panel.PercentagePanel.HeaderText, Panel.PercentagePanel.MinText, Panel.PercentagePanel.MaxText, function(Hovered, Active, Percent)
				if Panel.PercentagePanel.lastItem == Panel.PercentagePanel.currentItem then
					Panel.PercentagePanel.index = Percent
				else
					Panel.PercentagePanel.index = Panel.PercentagePanel[Panel.PercentagePanel.currentItem].index
				end
				if Active then
					Panel.PercentagePanel[Panel.PercentagePanel.currentItem].index = Percent

					Apperance[Panel.PercentagePanel.itemIndex].indextwo = math.floor(Percent*10)
					updateApperance(Panel.PercentagePanel.itemIndex, false)
				end
			end)
		end
	end)
end)


