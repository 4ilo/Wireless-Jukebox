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
        
        --buf = buf.. webpagina;
        local webpagina = "<!DOCTYPE html><html><head><title>TestPagina</title></head><body><h1>Wireless Jukebox</h1><div><ul><li>Liedje 1</li><li>Liedje 2</li><li>Liedje 3</li><li>Liedje 4</li></ul></div></body></html>";
        client:send(webpagina);
        client:close();
        collectgarbage();
    end)
end)
