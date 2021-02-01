session:setAutoHangup(false)
api = freeswitch.API()
session:setVariable("conference_min_three", "true")
local destination_number = session:getVariable("destination_number")
api:executeString("conference " .. destination_number ..
                      "@camera+flags{join-vid-floor} bgdial {loopback_bowout_on_execute=true}loopback/L" ..
                      destination_number .. "_V/users/XML 0000 CTTDCDS")
api:executeString("conference " .. destination_number ..
                      "@camera bgdial {loopback_bowout_on_execute=true}loopback/L" ..
                      destination_number .. "_A/users/XML 0000 CTTDCDS")
