Config = {}

-- [PL] Tylko przy jednej daj true // [ENG] Only in one position set to true
Config.UseItem = true
Config.UseCommand = false
Config.CommandName = "blackout" -- Command name

-------------------------------------------

Config.BlackoutTime = 20 --- SET IN SECONDS
Config.BlackoutResetTime = 60 * 20 -- SET IN SECONDS
Config.DriversPanic = false
Config.UseWelcomeNotify = false

----- NOTIFICATIONS
Config.BlackoutNotifyReset = "You can use this after "..Config.BlackoutResetTime.." seconds." -- Notification text for reset

-- ONLY IF Config.UseWelcomeNotify is set to true
Config.StartBlackoutNotify = "Text"
Config.EndBlackoutNotify = "Text"


