local cachePath = "R:/ytdl"
local nextIndex
local observeInitial
mp.enable_messages("info")

local function listener(event)
	if event.prefix == mp.get_script_name() then
		local destination = string.match(event.text, "%[download%] Destination: (.+).mkv") or 
		string.match(event.text, "%[download%] (.+).mkv has already been downloaded")
		if destination and string.find(destination,":\\") then
			mp.commandv("loadfile", destination..".mkv", "append", "audio-file="..destination..".webm")--,sub-file="..destination..".en.vtt") --in case they are not set up to autoload
			mp.commandv("playlist_move", mp.get_property("playlist-count") - 1 , nextIndex)
			mp.commandv("playlist_remove", nextIndex + 1)
			mp.unregister_event(listener)
		end
	end	
end

local function DL()
	mp.add_timeout(1, function()
	if tonumber(mp.get_property("playlist-pos-1"))>0 and mp.get_property("playlist-pos-1")~=mp.get_property("playlist-count") then
		nextIndex = tonumber(mp.get_property("playlist-pos")) + 1
		local nextFile = mp.get_property("playlist/"..tostring(nextIndex).."/filename")
		if nextFile and nextFile:find("://", 0, false) then
			mp.register_event("log-message", listener)
			mp.command_native_async({
				name="subprocess", 
				args = {"C:/mpv/youtube-dl.exe", "-f", "bestvideo", "--no-part", "-o", cachePath.."/%(title)s.mkv", nextFile},
				playback_only = false
			}, function() end)
			mp.command_native_async({
				name="subprocess", 
				args = {"C:/mpv/youtube-dl.exe", "-q", "-f", "bestaudio", "--no-part", "-o", cachePath.."/%(title)s.webm", nextFile},
				playback_only = false
			}, function() end)
			mp.command_native_async({
				name="subprocess", 
				args = {"youtube-dl", "-q", "--skip-download", "--sub-lang", "en", "--write-sub", "-o", cachePath.."/%(title)s", nextFile},
				playback_only = false
			}, function() end)		
		end
	end
	end)
end

local function clearCache()
	if package.config:sub(1,1) ~= '/' then
		os.execute('rd /s/q "'..cachePath..'"')
	else
		os.execute('rm -rd "'..cachePath..'"')
	end
end
local f=io.open(cachePath,"r")
if f~=nil then 
	io.close(f)
	clearCache()
end

mp.observe_property("playlist-count", "number", function() 
	if observeInitial then
		DL()
	else
		observeInitial = true
	end
end)
mp.register_event("start-file", DL)
mp.register_event("shutdown", clearCache)