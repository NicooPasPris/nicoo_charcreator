actionIndex, motherAct, fatherAct, clotheAct = 1, 1, 1, 1

FatherList = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 42, 43, 44}
MotherList = {21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 45}

HeritageShape = {
    h = 0.5,
    a = 0.5,
    i = 5,
    j = 5
}

SkinMixData = 0.1

PanelVisage = {
    Square = {
        enable = false,
        x = 0.5,
        y = 0.5,
        Top = Locales[Config.Locale]['top'],
        Bottom = Locales[Config.Locale]['bottom'],
        Left = Locales[Config.Locale]['left'],
        Right = Locales[Config.Locale]['right'],
    },

    Horizontal = {
        enable = false,
        x = 0.5,
        Left = Locales[Config.Locale]['left'],
        Right = Locales[Config.Locale]['right'],
    },

    Colour = {
        enable = false,
        color = RageUI.PanelColour.HairCut,
        itemIndex = 1,
        index_one = 1,
        index_two = 1,
        name = Locales[Config.Locale]['colour'],
    },

    Percentage = {
        enable = false,
        index = 1,
        itemIndex = 1,
        MinText = '0%',
        HeaderText = Locales[Config.Locale]['height'],
        MaxText = '100%'
    }

}

Visage = {}

lastCam = 'body'

ComponentVariation = {}
HeadOverlay = {}
ParentData = {mom = 0, dad = 0, shape_mx = 0.5, skin_mx = 0.5}

local ComponentClothe = {tshirt = 8, torso = 11, decals = 10, arms = 3, pants = 4, shoes = 6, chain = 7}
local PropIndexClothe = {helmet = 0, glasses = 1}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if RageUI.Visible(mainMenu) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                -- Sexe
                RageUI.List(Locales[Config.Locale]['gender_item'], {Locales[Config.Locale]['gender_male'], Locales[Config.Locale]['gender_female']}, actionIndex, Locales[Config.Locale]['gender_item_desc'], {}, true, function(Hovered, Active, Selected, Index)
                end, function(Index, Item)
                    actionIndex = Index
                    updateSex(Index-1)
                end)

                -- Héritage
                RageUI.Button(Locales[Config.Locale]['heritage_item'], Locales[Config.Locale]['heritage_item_desc'], {RightBadge = 17}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CreateSkinCam('face')
                    end
                 end, heritage)

                -- Visage
                RageUI.Button(Locales[Config.Locale]['visage_item'], Locales[Config.Locale]['visage_item_desc'],{RightBadge = 16}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CreateSkinCam('face')
                    end
                end, visage)

                -- Apparence
                RageUI.Button(Locales[Config.Locale]['apperance_item'], Locales[Config.Locale]['apperance_item_desc'],{RightBadge = 9}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CreateSkinCam('face')
                    end
                end, apperance)

                -- Clothe
                RageUI.List(Locales[Config.Locale]['clothe_item'], ClotheList, clotheAct, Locales[Config.Locale]['clothe_item_desc'], {}, true, function(Hovered, Active, Selected, Index)
                end, function(Index, Item) 
                    clotheAct = Index
                    updateClothe(clotheAct)
                end)

                RageUI.Button('', false,{}, true, function(Hovered, Active, Selected)
                end)

                RageUI.Button(Locales[Config.Locale]['confirm_item'], Locales[Config.Locale]['confirm_item_desc'], {RightBadge = 23, Color = {BackgroundColor = RageUI.ItemsColour.Gang1}}, true, function(Hovered, Active, Selected)
                    if Selected then
                        for k,v in pairs(HeadOverlay) do
                            TriggerEvent('skinchanger:saveWithFiveMFunc', k, 'headoverlay', v)
                        end
                        for k,v in pairs(ComponentVariation) do
                            TriggerEvent('skinchanger:saveWithFiveMFunc', k, 'componentvariation', v)
                        end

                        for k,v in pairs(ParentData) do
                            TriggerEvent('skinchanger:saveWithFiveMFunc', k, 'face', v)
                        end

                        for k,v in pairs(Visage) do
                            TriggerEvent('skinchanger:saveWithFiveMFunc', k, 'facefeature', v)
                        end

                        RageUI.CloseAll()
                        EndCharCreator()
                    end
                end)
            end, function() end)
        end

        if RageUI.Visible(heritage) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.HeritageWindow(ParentData['mom'], ParentData['dad'])

                RageUI.List(Locales[Config.Locale]['heritage_mother_item'], Config.MotherNamesList, motherAct, Locales[Config.Locale]['heritage_mother_item_desc'], {}, true, function(hovered,active,selected, Index)
                end, function(Index, Item)
                    motherAct = Index 
                    ParentData['mom'] = Index 
                    updateParent()
                end)

                RageUI.List(Locales[Config.Locale]['heritage_father_item'], Config.FatherNamesList, fatherAct, Locales[Config.Locale]['heritage_father_item_desc'], {}, true, function(hovered,active,selected, Index)
                end, function(Index, Item)
                    fatherAct = Index 
                    ParentData['dad'] = Index 
                    updateParent()
                end)

                RageUI.UISliderHeritage(Locales[Config.Locale]['resemblance_item'], HeritageShape.i, Locales[Config.Locale]['resemblance_item_desc'], function(Hovered, Selected, Active, Heritage, Index)
                    if (Selected) then
                        if (HeritageShape.h ~= Heritage) then
                            HeritageShape.h = Heritage
                            HeritageShape.i = Index
                            ParentData['shape_mx'] = Heritage
                        end
                        updateParent()
                    end
                end, 0.1)

                RageUI.UISliderHeritage(Locales[Config.Locale]['resemblance_item'], HeritageShape.j, Locales[Config.Locale]['resemblance_item_desc'], function(Hovered, Selected, Active, Heritage, Index)
                    if (Selected) then
                        if (HeritageShape.a ~= Heritage) then
                            HeritageShape.a = Heritage
                            HeritageShape.j = Index
                            ParentData['skin_mx'] = Heritage
                        end

                        updateParent()
                    end
                end, 0.01)
            end)
        end

        if RageUI.Visible(visage) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button(Locales[Config.Locale]['nose'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {5, 1, 'nez'}, Locales[Config.Locale]['top'], Locales[Config.Locale]['bottom'], Locales[Config.Locale]['narrow'], Locales[Config.Locale]['large'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['profil_nose'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {6, 4, 'profil_nez'}, Locales[Config.Locale]['curve'], Locales[Config.Locale]['curved'], Locales[Config.Locale]['short'], Locales[Config.Locale]['long'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['pointe_nose'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {2, 3, 'pointe_nez'}, Locales[Config.Locale]['broke_left'], Locales[Config.Locale]['broke_right'], Locales[Config.Locale]['peak_high'], Locales[Config.Locale]['peak_low'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['eyebrows'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {7, 8, 'sourcil'}, Locales[Config.Locale]['top'], Locales[Config.Locale]['bottom'], Locales[Config.Locale]['retracted'], Locales[Config.Locale]['out'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['cheekbones'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {9, 10, 'pommettes'}, Locales[Config.Locale]['top'], Locales[Config.Locale]['bottom'], Locales[Config.Locale]['retracted'], Locales[Config.Locale]['out'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['cheek'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Horizontal', {13, 'joues'}, Locales[Config.Locale]['dig'], Locales[Config.Locale]['inflate'], {Min = -2.0, Max = 2.0})
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['eyes'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Horizontal', {11, 'yeux'}, Locales[Config.Locale]['opened_eyes'], Locales[Config.Locale]['narrowed_eyes'], {Min = -2.0, Max = 1.0})
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['lips'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Horizontal', {12, 'levres'}, Locales[Config.Locale]['thick'], Locales[Config.Locale]['thin'], {Min = -2.0, Max = 2.0})
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['jaw'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {14, 15, 'machoire'}, Locales[Config.Locale]['large'], Locales[Config.Locale]['square'], Locales[Config.Locale]['narrow'], Locales[Config.Locale]['round'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['profil_chin'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {16, 17, 'profil_menton'}, Locales[Config.Locale]['retracted'], Locales[Config.Locale]['out'], Locales[Config.Locale]['bottom'], Locales[Config.Locale]['top'])
                    end 
                end)

                RageUI.Button(Locales[Config.Locale]['shape_chin'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Square', {20, 18, 'forme_menton'}, Locales[Config.Locale]['rounded'], Locales[Config.Locale]['dimple'], Locales[Config.Locale]['sharp'], Locales[Config.Locale]['square'])
                    end
                end)

                RageUI.Button(Locales[Config.Locale]['neck_thickness'], false, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        updatePanel('Horizontal', {19, 'cou'}, Locales[Config.Locale]['thin'], Locales[Config.Locale]['large'])
                    end 
                end)
            end, function()
                if PanelVisage.Square.enable then
                    RageUI.GridPanel(PanelVisage.Square.x, PanelVisage.Square.y, PanelVisage.Square.Top, PanelVisage.Square.Bottom, PanelVisage.Square.Left, PanelVisage.Square.Right, function(Hovered, Active, X, Y)
                        if PanelVisage.Square.lastItem == PanelVisage.Square.currentItem then
                            PanelVisage.Square.x = X
                            PanelVisage.Square.y = Y
                        else
                            PanelVisage.Square.x = PanelVisage.Square[PanelVisage.Square.currentItem].x
                            PanelVisage.Square.y = PanelVisage.Square[PanelVisage.Square.currentItem].y
                        end
                        if Active then
                            PanelVisage.Square[PanelVisage.Square.currentItem].x = X
                            PanelVisage.Square[PanelVisage.Square.currentItem].y = Y   

                            local x = PanelVisage.Square[PanelVisage.Square.currentItem].x
                            local y = PanelVisage.Square[PanelVisage.Square.currentItem].y                 

                            SetPedFaceFeature(GetPlayerPed(-1), PanelVisage.Square.IndexX, x)
                            SetPedFaceFeature(GetPlayerPed(-1), PanelVisage.Square.IndexY, y)
                            Visage[PanelVisage.Square.IndexX] = x
                            Visage[PanelVisage.Square.IndexY] = y
                        end

                    end)
                end

                if PanelVisage.Horizontal.enable then
                    RageUI.GridPanelHorizontal(PanelVisage.Horizontal.x, PanelVisage.Horizontal.Left, PanelVisage.Horizontal.Right, function(Hovered, Active, X, x)
                        if PanelVisage.Horizontal.lastItem == PanelVisage.Horizontal.currentItem then
                            PanelVisage.Horizontal.x = X
                            PanelVisage.Horizontal.y = Y
                        else
                            PanelVisage.Horizontal.x = PanelVisage.Horizontal[PanelVisage.Horizontal.currentItem].x
                            PanelVisage.Horizontal.y = PanelVisage.Horizontal[PanelVisage.Horizontal.currentItem].y
                        end

                        if Active then
                            SetPedFaceFeature(GetPlayerPed(-1), PanelVisage.Horizontal.IndexX, x)
                            Visage[PanelVisage.Horizontal.IndexX] = x
                        end
                    end, PanelVisage.Horizontal.Data)
                end
            end)
        end

        if RageUI.Visible(apperance) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                for k,v in ipairs(Apperance) do
                    RageUI.List(Locales[Config.Locale][v.item], v.List, v.index, Locales[Config.Locale][v.item..'_desc'], {}, true, function(Hovered, Active, Selected, Index)
                        if Active then
                            if v.ColourPanel and v.PercentagePanel then
                                updatePanel('Colour', k, true)
                            elseif v.ColourPanel and not v.PercentagePanel then
                                updatePanel('Colour', k)
                            elseif not v.ColourPanel and v.PercentagePanel then
                                updatePanel('Percentage', k)
                            elseif not v.ColourPanel and not v.PercentagePanel then
                                updatePanel()
                            end

                            if v.cam ~= lastCam then
                                lastCam = v.cam
                                CreateSkinCam(v.cam)
                            end
                        end
                    end, function(Index, Item)
                        v.index = Index
                        updateApperance(k, true)
                    end)
                end
            end, function()
                if PanelVisage.Colour.enable then
                    RageUI.ColourPanel(PanelVisage.Colour.name, PanelVisage.Colour.color, PanelVisage.Colour.index_one, PanelVisage.Colour.index_two, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if Active then
                            PanelVisage.Colour.index_one = MinimumIndex
                            PanelVisage.Colour.index_two = CurrentIndex
                            
                            Apperance[PanelVisage.Colour.itemIndex].indextwo = math.floor(CurrentIndex+0.0)
                            updateApperance(PanelVisage.Colour.itemIndex, false, true)
                        end
                    end)
                end

                if PanelVisage.Percentage.enable then
                    RageUI.PercentagePanel(PanelVisage.Percentage.index, PanelVisage.Percentage.HeaderText, PanelVisage.Percentage.MinText, PanelVisage.Percentage.MaxText, function(Hovered, Active, Percent)
                        if Active then
                            PanelVisage.Percentage.index = Percent
                            Apperance[PanelVisage.Percentage.itemIndex].indextwo = math.floor(Percent*10+0.0)
                            updateApperance(PanelVisage.Percentage.itemIndex)
                        end
                    end)
                end
            end)
        end
    end
end)

function updateParent()
    local playerPed = GetPlayerPed(-1)
    SetPedHeadBlendData(playerPed, ParentData['dad'], ParentData['mom'], 0, ParentData['dad'], ParentData['mom'], 0, ParentData['shape_mx'], ParentData['skin_mx'], 0.0, true)
end

function updateSex(sex)
    local skin = 'mp_m_freemode_01'
    if sex == 1 then
        skin = 'mp_f_freemode_01'
    end
    changemodel(skin)
end

function changemodel(skin)
    local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)

        local playerPed = GetPlayerPed(-1)
        SetPedHeadBlendData(playerPed, ParentData['dad'], ParentData['mom'], 0, ParentData['dad'], ParentData['mom'], 0, ParentData['shape_mx'], ParentData['skin_mx'], 0.0, true)

        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then 
            SetPedRandomComponentVariation(GetPlayerPed(-1), true)
            
        elseif skin == "mp_m_freemode_01" then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)--arm
            ComponentVariation['arms'] = {15, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 11, 15, 0, 2)--torso_1
            ComponentVariation['torso'] = {15, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)--t short
            ComponentVariation['tshirt'] = {15, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 4, 61, 4, 2)--pants_1
            ComponentVariation['pants'] = {61, 4}
            SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 2)--shoes_1
            ComponentVariation['shoes'] = {34, 0}
        elseif skin == "mp_f_freemode_01" then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)--arm
            ComponentVariation['arms'] = {15, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 2)--torso_1
            ComponentVariation['torso'] = {11, 5}
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)--t short
            ComponentVariation['tshirt'] = {15, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 4, 57, 0, 2)--pants_1
            ComponentVariation['pants'] = {57, 0}
            SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2)--shoes_1
            ComponentVariation['shoes'] = {35, 0}
        end

        for i=1, 20, 1 do
            if Visage[i] then
                SetPedFaceFeature(GetPlayerPed(-1), i, Visage[i])
            end
        end

        SetModelAsNoLongerNeeded(model)
    end
end

function updatePanel(Panel, Index, Top, Bottom, Left, Right)
    
    for k,v in pairs(PanelVisage) do
        if k == Panel then
            v.enable = true
        else
            v.enable = false
        end
    end

    if Panel == 'Square' then
        PanelVisage[Panel].Top = Top
        PanelVisage[Panel].Bottom = Bottom
        PanelVisage[Panel].Left = Left
        PanelVisage[Panel].Right = Right
        PanelVisage[Panel].IndexX = Index[1]
        PanelVisage[Panel].IndexY = Index[2]
        if not PanelVisage[Panel].currentItem then
            PanelVisage[Panel].lastItem = Index[3]
        else
            PanelVisage[Panel].lastItem = PanelVisage[Panel].currentItem
        end
        PanelVisage[Panel].currentItem = Index[3]

        if not PanelVisage[Panel][PanelVisage[Panel].currentItem] then
            PanelVisage[Panel][PanelVisage[Panel].currentItem] = {
                x = 0.5,
                y = 0.5
            }
        end
    end

    if Panel == 'Horizontal' then
        PanelVisage[Panel].Left = Top
        PanelVisage[Panel].Right = Bottom
        PanelVisage[Panel].IndexX = Index[1]
        if Left then
            PanelVisage[Panel].Data = Left
        else
            PanelVisage[Panel].Data = nil
        end

        if not PanelVisage[Panel].currentItem then
            PanelVisage[Panel].lastItem = Index[2]
        else
            PanelVisage[Panel].lastItem = PanelVisage[Panel].currentItem
        end
        PanelVisage[Panel].currentItem = Index[2]

        if not PanelVisage[Panel][PanelVisage[Panel].currentItem] then
            PanelVisage[Panel][PanelVisage[Panel].currentItem] = {
                x = 0.5,
                y = 0.5
            }
        end
    end

    if Panel == 'Colour' then
        PanelVisage[Panel].itemIndex = Index
        if Top then
            PanelVisage.Percentage.enable = true
            PanelVisage.Percentage.itemIndex = Index
        end
        if Bottom then
            PanelVisage[Panel].name = Bottom
        end

        if Left then
            PanelVisage[Panel].color = Left
        end
    end 

    if Panel == 'Percentage' then
        PanelVisage[Panel].itemIndex = Index
        if Top then
            PanelVisage.Colour.enable = true
            PanelVisage.Colour.itemIndex = Index
        end

        if Bottom then
            PanelVisage[Panel].HeaderText = Bottom
        end

        if Left then
            PanelVisage[Panel].MinText = Left
        end

        if Right then
            PanelVisage[Panel].MaxText = Right
        end
    end
end

function updateApperance(id, selected, color)
    local app = Apperance[id]
    local playerPed = PlayerPedId()

    if selected then
        if app.itemType == 'component' then
            ComponentVariation[app.item] = {app.index, 0}
            SetPedComponentVariation(playerPed, app.itemID, app.index, 0, 2)
        elseif app.itemType == 'headoverlay' then
            HeadOverlay[app.item] = {app.index, 10.0}
            SetPedHeadOverlay(playerPed, app.itemID, app.index, 10.0)
        elseif app.itemType == 'eye' then
            ParentData['eye_color'] = app.index
            SetPedEyeColor(playerPed, app.index, 0, 1)
        end
    end

    if not selected then
        if app.itemType == 'component' then
            ComponentVariation[app.item] = {app.index, 0}
            SetPedComponentVariation(playerPed, app.itemID, app.index, 0, 2)
        elseif app.itemType == 'headoverlay' then
            HeadOverlay[app.item] = {app.index, app.indextwo+0.0}
            SetPedHeadOverlay(playerPed, app.itemID, app.index, app.indextwo+0.0)
        elseif app.itemType == 'eye' then
            ParentData['eye_color'] = app.index
            SetPedEyeColor(playerPed, app.index, 0, 1)
        end
    end

    if not selected and color then
        if app.itemType == 'component' then
            SetPedHairColor(playerPed, app.indextwo, 0)
        elseif app.itemType == 'headoverlay' then
            HeadOverlay[app.item] = {HeadOverlay[app.item][1], HeadOverlay[app.item][2], app.indextwo, 0}
            SetPedHeadOverlayColor(playerPed, app.itemID, 1, app.indextwo, 0)
        end
    end
end

function updateClothe(index)
    local clothe = Config.Tenue[index]
    local gender = 'male'

    local playerPed = PlayerPedId()

    for k,v in pairs(clothe.id[gender]) do
        if k == 'helmet' or k == 'glasses' then
            SetPedPropIndex(playerPed, PropIndexClothe[k], v[1], v[2])
        else
            ComponentVariation[k] = {v[1], v[2]}
            SetPedComponentVariation(playerPed, ComponentClothe[k], v[1], v[2])
        end
    end
end
