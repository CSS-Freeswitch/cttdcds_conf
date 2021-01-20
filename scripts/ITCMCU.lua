function Split(szFullString, szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
        local nFindLastIndex = string.find(szFullString, szSeparator,
                                           nFindStartIndex)
        if not nFindLastIndex then
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex,
                                                  string.len(szFullString))
            break
        end
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex,
                                              nFindLastIndex - 1)
        nFindStartIndex = nFindLastIndex + string.len(szSeparator)
        nSplitIndex = nSplitIndex + 1
    end
    return nSplitArray
end

session:setAutoHangup(false)
api = freeswitch.API()
local destination_number = session:getVariable("destination_number")
local domain_name = session:getVariable("domain_name")
local sofia_contact = api:executeString(
                          "sofia_contact */" .. destination_number .. "@" ..
                              domain_name)
freeswitch.consoleLog("INFO", "sofia_contact " .. destination_number .. "@" ..
                          domain_name .. "\n")
freeswitch.consoleLog("INFO", "get MCU contact:" .. sofia_contact .. "\n")
local sdp = session:getVariable("switch_r_sdp")
-- if (string.find(sdp, "H264") ~= nil) then
--     session:setVariable("record_concat_video", "true")
--     session:setVariable("execute_on_answer",
--                         "record_session /home/record/${strftime(%Y-%m-%d-%H:%M:%S)}_${dialed_extension}_${caller_id_number}.mp4")
-- else
--     session:setVariable("execute_on_answer",
--                         "record_session /home/record/${strftime(%Y-%m-%d-%H:%M:%S)}_${dialed_extension}_${caller_id_number}.wav")
-- end
local contact = Split(sofia_contact, ":")
if (contact[2] ~= nil) then
    local contact_split = Split(contact[2], "@")
    if (contact_split[1] ~= nil) then
        contact_ip = contact_split[2]
    else
        contact_ip = "NULL"
    end
end
freeswitch.consoleLog("INFO",
                      "destination user's contact_ip:" .. contact_ip .. "\n")
if (contact_ip ~= nil) then
    session:setVariable("contact_ip", "sip:" .. contact_ip .. ":5060")
end
