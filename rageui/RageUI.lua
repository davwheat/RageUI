---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---


---round
---@param num number
---@param numDecimalPlaces number
---@return number
---@public
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---starts
---@param String string
---@param Start number
---@return number
---@public
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@type table
RageUI = {}

---@type table
RageUI.Menus = setmetatable({}, RageUI.Menus)

---@type table
---@return boolean
RageUI.Menus.__call = function()
    return true
end

---@type table
RageUI.Menus.__index = RageUI.Menus

---@type table
RageUI.CurrentMenu = nil

---@type table
RageUI.NextMenu = nil

---@type number
RageUI.Options = 0

---@type number
RageUI.ItemOffset = 0

---@type table
RageUI.Settings = {
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Library = "HUD_FRONTEND_DEFAULT_SOUNDSET",
        UpDown = "NAV_UP_DOWN",
        LeftRight = "NAV_LEFT_RIGHT",
        Select = "SELECT",
        Back = "BACK",
        Error = "ERROR",
        Slider = "CONTINUOUS_SLIDER",
        Id = nil,
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
}

---PlaySound
---@param Library string
---@param Sound string
---@param IsLooped boolean
---@return nil
---@public
function RageUI.PlaySound(Library, Sound, IsLooped)
    if not IsLooped then
        PlaySoundFrontend(-1, Sound, Library, true)
    else
        if not RageUI.Settings.Audio.Id then
            Citizen.CreateThread(function()
                RageUI.Settings.Audio.Id = GetSoundId()

                PlaySoundFrontend(RageUI.Settings.Audio.Id, Sound, Library, true)

                Citizen.Wait(0.01)

                StopSound(RageUI.Settings.Audio.Id)

                ReleaseSoundId(RageUI.Settings.Audio.Id)

                RageUI.Settings.Audio.Id = nil
            end)
        end
    end
end

---Visible
---@param Menu function
---@param Value boolean
---@return table
---@public
function RageUI.Visible(Menu, Value)
    if Menu ~= nil then
        if Menu() then
            if type(Value) == "boolean" then
                Menu.Open = Value
                if Menu.Open then
                    Menu:UpdateInstructionalButtons(Value);
                    RageUI.CurrentMenu = Menu
                    RageUI.Options = 0
                    RageUI.ItemOffset = 0
                else
                    RageUI.CurrentMenu = nil
                    RageUI.Options = 0
                    RageUI.ItemOffset = 0
                end
            else
                return Menu.Open
            end
        end
    end
end

---Title
---@return nil
---@public
---@param Enabled boolean
function RageUI.Banner(Enabled)
    if type(Enabled) == "boolean" then
        if Enabled == true then


            if RageUI.CurrentMenu ~= nil then
                if RageUI.CurrentMenu() then


                    RageUI.ItemsSafeZone(RageUI.CurrentMenu)

                    if RageUI.CurrentMenu.Sprite then
                        RenderSprite(RageUI.CurrentMenu.Sprite.Dictionary, RageUI.CurrentMenu.Sprite.Texture, RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, nil, RageUI.CurrentMenu.Sprite.Color.R, RageUI.CurrentMenu.Sprite.Color.G, RageUI.CurrentMenu.Sprite.Color.B, RageUI.CurrentMenu.Sprite.Color.A)
                    else
                        RenderRectangle(RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, RageUI.CurrentMenu.Rectangle.R, RageUI.CurrentMenu.Rectangle.G, RageUI.CurrentMenu.Rectangle.B, RageUI.CurrentMenu.Rectangle.A)
                    end


                    local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                    Citizen.CreateThread(function()
                        if not HasScaleformMovieLoaded(ScaleformMovie) then
                            ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                            while not HasScaleformMovieLoaded(ScaleformMovie) do
                                Citizen.Wait(0)
                            end
                        end
                    end)

                    local Glarewidth = RageUI.Settings.Items.Title.Background.Width + RageUI.CurrentMenu.WidthOffset
                    local Glareheight  = RageUI.Settings.Items.Title.Background.Height

                    --- TODO Automatic scaling
                    local GlareX = 0.5450
                    local GalreY = 0.482
                    DrawScaleformMovie(ScaleformMovie, GlareX, GalreY, Glarewidth / 430, Glareheight / 100, 255, 51, 204, 255, 0)



                    RenderText(RageUI.CurrentMenu.Title, RageUI.CurrentMenu.X + RageUI.Settings.Items.Title.Text.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Items.Title.Text.Y, 1, RageUI.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)

                    RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Title.Background.Height
                end
            end
        end
    else
        error("Enabled is not boolean")
    end
end

---CloseAll -- TODO 
---@return nil
---@public
-- function RageUI:CloseAll()
--     RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Back)
--     RageUI.NextMenu = nil
--     RageUI.Visible(RageUI.CurrentMenu, false)
-- end

---Subtitle
---@return nil
---@public
function RageUI.Subtitle()
    if RageUI.CurrentMenu ~= nil then
        if RageUI.CurrentMenu() then

            RageUI.ItemsSafeZone(RageUI.CurrentMenu)

            if RageUI.CurrentMenu.Subtitle ~= "" then
                RenderRectangle(RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y + RageUI.ItemOffset, RageUI.Settings.Items.Subtitle.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Items.Subtitle.Background.Height + RageUI.CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
                RenderText(RageUI.CurrentMenu.Subtitle, RageUI.CurrentMenu.X + RageUI.Settings.Items.Subtitle.Text.X, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Subtitle.Text.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + RageUI.CurrentMenu.WidthOffset)
                if RageUI.CurrentMenu.PageCounter == nil then
                    if RageUI.CurrentMenu.Options >= RageUI.CurrentMenu.Pagination.Total + 1 then
                        RenderText(RageUI.CurrentMenu.PageCounterColour .. RageUI.CurrentMenu.Index .. " / " .. RageUI.CurrentMenu.Options, RageUI.CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + RageUI.CurrentMenu.WidthOffset, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    end
                else
                    RenderText(RageUI.CurrentMenu.PageCounter, RageUI.CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + RageUI.CurrentMenu.WidthOffset, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                end

                RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

---Background
---@return nil
---@public
function RageUI.Background()
    if RageUI.CurrentMenu ~= nil then
        if RageUI.CurrentMenu() then

            RageUI.ItemsSafeZone(RageUI.CurrentMenu)

            SetScriptGfxDrawOrder(0)
            RenderSprite(RageUI.Settings.Items.Background.Dictionary, RageUI.Settings.Items.Background.Texture, RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Background.Y + RageUI.CurrentMenu.SubtitleHeight, RageUI.Settings.Items.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.ItemOffset, 0, 0, 0, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

---Description
---@return nil
---@public
function RageUI.Description()
    if RageUI.CurrentMenu ~= nil and RageUI.CurrentMenu.Description ~= nil then
        if RageUI.CurrentMenu() then

            RageUI.ItemsSafeZone(RageUI.CurrentMenu)

            RenderRectangle(RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Description.Bar.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Items.Description.Bar.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
            RenderSprite(RageUI.Settings.Items.Description.Background.Dictionary, RageUI.Settings.Items.Description.Background.Texture, RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Description.Background.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Items.Description.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
            RenderText(RageUI.CurrentMenu.Description, RageUI.CurrentMenu.X + RageUI.Settings.Items.Description.Text.X, RageUI.CurrentMenu.Y + RageUI.Settings.Items.Description.Text.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, RageUI.Settings.Items.Description.Background.Width + RageUI.CurrentMenu.WidthOffset)

            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.CurrentMenu.DescriptionHeight + RageUI.Settings.Items.Description.Bar.Y
        end
    end
end

--- TODO

function RageUI.Header(EnabledBanner)
    RageUI.Banner(EnabledBanner)
    RageUI.Subtitle()
end
---GoBack
---@return nil
---@public
function RageUI.GoBack()
    if RageUI.CurrentMenu ~= nil then
        RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Back)
        if RageUI.CurrentMenu.Parent ~= nil then
            if RageUI.CurrentMenu.Parent() then
                RageUI.NextMenu = RageUI.CurrentMenu.Parent
            else
                RageUI.NextMenu = nil
                RageUI.Visible(RageUI.CurrentMenu, false)
            end
        else
            RageUI.NextMenu = nil
            RageUI.Visible(RageUI.CurrentMenu, false)
        end
    end
end
---Render
---@param instructionalButton boolean
---@return nil
---@public
function RageUI.Render(instructionalButton)
    if RageUI.CurrentMenu ~= nil then
        if RageUI.CurrentMenu() then

            if RageUI.CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end

            if (instructionalButton) then
                DrawScaleformMovieFullscreen(RageUI.CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end

            RageUI.CurrentMenu.Options = RageUI.Options
            RageUI.CurrentMenu.SafeZoneSize = nil

            RageUI.Controls()

            RageUI.Options = 0
            RageUI.ItemOffset = 0

            if RageUI.CurrentMenu.Controls.Back.Enabled and RageUI.CurrentMenu.Closable then
                if RageUI.CurrentMenu.Controls.Back.Pressed then
                    RageUI.CurrentMenu.Controls.Back.Pressed = false

                    RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Back)
                    if RageUI.CurrentMenu.Closed ~= nil then
                        RageUI.CurrentMenu.Closed()
                    end
                    if RageUI.CurrentMenu.Parent ~= nil then
                        if RageUI.CurrentMenu.Parent() then
                            RageUI.NextMenu = RageUI.CurrentMenu.Parent
                        else
                            RageUI.NextMenu = nil
                            RageUI.Visible(RageUI.CurrentMenu, false)
                        end
                    else
                        RageUI.NextMenu = nil
                        RageUI.Visible(RageUI.CurrentMenu, false)
                    end
                end
            end

            if RageUI.NextMenu ~= nil then
                if RageUI.NextMenu() then
                    RageUI.Visible(RageUI.CurrentMenu, false)
                    RageUI.Visible(RageUI.NextMenu, true)
                    RageUI.CurrentMenu.Controls.Select.Active = false
                end
            end
        end
    end
end

---DrawContent
---@param items function
---@param panels function
function RageUI.DrawContent(settings, items, panels)
    if (settings.header ~= nil) then
        RageUI.Header(settings.header);
    else
        RageUI.Header(true);
    end
    if (items ~= nil) then
        items()
    end
    RageUI.Background();
    RageUI.Navigation();
    RageUI.Description();
    if (panels ~= nil) then
        panels()
    end
    if (settings.instructionalButton ~= nil) then
        RageUI.Render(settings.instructionalButton)
    else
        RageUI.Render(true)
    end
end

---ItemsDescription
---@param CurrentMenu table
---@param Description string
---@param Selected boolean
---@return nil
---@public
function RageUI.ItemsDescription(CurrentMenu, Description, Selected)

    ---@type table
    local SettingsDescription = RageUI.Settings.Items.Description;

    if Selected and CurrentMenu.Description ~= Description then

        CurrentMenu.Description = Description or nil

        ---@type number
        local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + CurrentMenu.WidthOffset)

        if DescriptionLineCount > 1 then
            CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
        else
            CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
        end
    end
end

---MouseBounds
---@param CurrentMenu table
---@param Selected boolean
---@param Option number
---@param SettingsButton table
---@return boolean
---@public
function RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)

    ---@type boolean
    local Hovered = false

    Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)

    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Error)
        end
    end

    return Hovered;
end

---ItemsSafeZone
---@param CurrentMenu table
---@return nil
---@public
function RageUI.ItemsSafeZone(CurrentMenu)

    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end

end