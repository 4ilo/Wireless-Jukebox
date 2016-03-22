print("Wireless jukebox-esp V1.0")

-- De globale variabelen om het aantal stemmen bij te houden
song1 = 0
song2 = 0
song3 = 0
song4 = 0

songTitle1 = ""
songTitle2 = ""
songTitle3 = ""
songTitle4 = ""

-- Deze functie zet de juiste liedjes in de variabelen
function setSong(nr, titel)
    if(titel ~= nil) then
        if(nr == 1) then
        	songTitle1 = titel
        elseif(nr == 2) then
          	songTitle2 = titel
        elseif(nr == 3) then
           	songTitle3 = titel
        elseif(nr == 4) then
           	songTitle4 = titel
        else
           	uart.write(0,"ERROR")
        end
    end
end

-- Returnt het meest gestemde liedjesId
function getBest()
	local lijst = {}
	lijst[1] = song1
	lijst[2] = song2
	lijst[3] = song3
	lijst[4] = song4
	table.sort(lijst)

	if(lijst[4] == song1) then
		uart.write(0,"1\n")
	elseif(lijst[4] == song2) then
		uart.write(0,"2\n")
	elseif(lijst[4] == song3) then
		uart.write(0,"3\n")
	elseif(lijst[4] == song4) then
		uart.write(0,"4\n")
	end

	resetSongs()

end

-- Functie zet alle tellers terug op 0
function resetSongs()
	song1 = 0
	song2 = 0
	song3 = 0
	song4 = 0
end

-- Een functie die bijhoud hoeveel er op elk liedje gestemd wordt
function count( vote )
    if(vote == '1') then
        song1 = song1 + 1;
    elseif(vote == '2') then
        song2 = song2 + 1;
    elseif(vote == '3') then
        song3 = song3 + 1;
    elseif(vote == '4') then
        song4 = song4 + 1;
    end
end

-- Een tijdelijke functie om status te tonen
function printSongs()
    print("Song1:" .. song1)
    print("Song2:" .. song2)
    print("Song3:" .. song3)
    print("Song4:" .. song4)
end

-- Een functie die in het html bestand zoekt naar de plaats om de titels in te vullen
function checkIfSongTitle( line )
    if (line:find("##SONG1##") ~= nil) then
        line = songTitle1
    elseif (line:find("##SONG2##") ~= nil) then
        line = songTitle2
    elseif (line:find("##SONG3##") ~= nil) then
        line = songTitle3
    elseif (line:find("##SONG4##") ~= nil) then
        line = songTitle4
    end
    return line;
end

local str=wifi.ap.getmac();
--wifi.setmode(wifi.STATIONAP)       -- instellen als acces point en wifi zoeken
wifi.setmode(wifi.SOFTAP)

--wifi.sta.config("Van den Eede","a123456789")
     
local cfg={}
cfg.ssid="Wireless jukebox";            -- De acces point instellingen
cfg.pwd="12345678"
wifi.ap.config(cfg)
cfg={}
cfg.ip="192.168.2.1";
cfg.netmask="255.255.255.0";
cfg.gateway="192.168.2.1";
wifi.ap.setip(cfg);

uart.setup(0,9600,8,0,1)      -- We initialiseren de uart voor communicatie
     --uart.write(0,"Wireless jukebox webserver V1.0\n")
    
-- We starten de server op op poort 80
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        
        -- Eerst kijken we of er een get request is om titels op te vragen
        if(_GET.titels) then
            
            --conn:send("HTTP/1.0 200 OK\n")
        	--conn:send("Server: ESP (Wireless jukebox)\n")
        	--conn:send("Content-Length: 1\n")
            --conn:send("Content-Type: application/json\n")		-- Het is een json response
            
            
            client:send('[');
            client:send('{ "Titel" : "' .. songTitle1 .. ' "},')
            client:send('{ "Titel" : "' .. songTitle2 .. ' "},')
            client:send('{ "Titel" : "' .. songTitle3 .. ' "},')
            client:send('{ "Titel" : "' .. songTitle4 .. ' "}' )
            client:send(']')

        else
            -- We openen de file en sturen het lijn per lijn naar de client
            --conn:send('HTTP/1.1 200 OK\n\n')
            --conn:send("Server: ESP (Wireless jukebox)\n\n")
            file.open('webpagina.html','r')
            local line = file.readline()
            while (line) do
                line = checkIfSongTitle(line)      -- We kijken of er een titel moet komen, 
                client:send(line)                  --  en vervanen als het nodig is
                line = file.readline()
            end
            file.close()
            count(_GET.next)		-- We tellen het aantal stemmen
            printSongs()
        end
        --client:on("sent", function(client) client:close() end)
        client:close();
        collectgarbage();
    end)
end)