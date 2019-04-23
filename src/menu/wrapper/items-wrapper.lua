---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 22/04/2019 01:54
---

---@type table
ItemsWrapper = {}

---ItemsDescription
---@param CurrentMenu table
---@param Description string
---@param Selected boolean
---@return nil
---@public
function ItemsWrapper.ItemsDescription(CurrentMenu, Description, Selected )

    ---@type table
    local SettingsDescription = RageUI.Settings.Items.Description;

    if Selected and CurrentMenu.Description ~= Description then

        CurrentMenu.Description = Description or nil

        ---@type number
        local DescriptionLineCount = RageUI.GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + CurrentMenu.WidthOffset)

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
function ItemsWrapper.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)

    ---@type boolean
    local Hovered = false

    Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)

    if Hovered and not Selected then
        RageUI.RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
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
function ItemsWrapper.ItemsSafeZone(CurrentMenu)

    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUI.GetSafeZoneBounds()

            ScreenDrawPositionBegin(76, 84)
            ScreenDrawPositionRatio(0, 0, 0, 0)
        end
    end

end