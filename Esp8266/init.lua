print("Ready to start soft ap AND station")
     local str=wifi.ap.getmac();
     wifi.setmode(wifi.SOFTAP)       -- instellen als acces point en wifi zoeken
     
     local cfg={}
     cfg.ssid="Olivier";            -- De acces point instellingen
     cfg.pwd="12345678"
     wifi.ap.config(cfg)
     cfg={}
     cfg.ip="192.168.2.1";
     cfg.netmask="255.255.255.0";
     cfg.gateway="192.168.2.1";
     wifi.ap.setip(cfg);
    

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

        print("start lezen file");
        
        local line;
        line = file.readline();
        while (line) do
            client:send(line);
            line = file.readline();
        end
        
        file.close();
        
        client:close();
        collectgarbage();
    end)
end)
