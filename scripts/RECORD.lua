session:setAutoHangup(false)
local sdp = session:getVariable("switch_r_sdp")
if (string.find(sdp, "H264") ~= nil) then
    session:setVariable("record_concat_video", "true")
    session:setVariable("execute_on_answer",
                        "record_session /home/record/${strftime(%Y-%m-%d-%H:%M:%S)}_${dialed_extension}_${caller_id_number}.mp4")
else
    session:setVariable("execute_on_answer",
                        "record_session /home/record/${strftime(%Y-%m-%d-%H:%M:%S)}_${dialed_extension}_${caller_id_number}.wav")
end
