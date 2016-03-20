print("Ready to start soft ap AND station")
     local str=wifi.ap.getmac();
     wifi.setmode(wifi.SOFTAP)       -- instellen als acces point en wifi zoeken
     
     local cfg={}
     cfg.ssid="Wireless jukebox";            -- De acces point instellingen
     --cfg.pwd="12345678"
     wifi.ap.config(cfg)
     cfg={}
     cfg.ip="192.168.2.1";
     cfg.netmask="255.255.255.0";
     cfg.gateway="192.168.2.1";
     wifi.ap.setip(cfg);

     uart.setup(0,9600,8,0,1)      -- We initialiseren de uart voor communicatie
     uart.write(0,"Wireless jukebox webserver V1.0\n")

     --testfunctie voor uart receive

    function data( data )
        if(data ~= nil) then
            print( data .. " received")
        else
            print("nil")
        end
    end



-- De globale variabelen om het aantal stemmen bij te houden
song1 = 0
song2 = 0
song3 = 0
song4 = 0

songTitle1 = "Missing - EDX"
songTitle2 = "Faded - Alan Walker"
songTitle3 = "Perfect - One Direction"
songTitle4 = "Sorry - Justin Bieber"

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
    

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
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
        
        -- We openen de file en sturen het lijn per lijn naar de client
        file.open('webpagina.html','r');
        local line = file.readline();
        while (line) do
            line = checkIfSongTitle(line);      -- We kijken of er een titel moet komen, 
            client:send(line);                  --  en vervanen als het nodig is
            line = file.readline();
        end
        file.close();

        count(_GET.next);
        printSongs();
        
        client:close();
        collectgarbage();
    end)
end)
