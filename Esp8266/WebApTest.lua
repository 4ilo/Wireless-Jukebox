print("Ready to start soft ap AND station")
     local str=wifi.ap.getmac();
     wifi.setmode(wifi.STATIONAP)       -- instellen als acces point en wifi zoeken
     
     local cfg={}
     cfg.ssid="Olivier";            -- De acces point instellingen
     cfg.pwd="12345678"
     wifi.ap.config(cfg)
     cfg={}
     cfg.ip="192.168.2.1";
     cfg.netmask="255.255.255.0";
     cfg.gateway="192.168.2.1";
     wifi.ap.setip(cfg);
     
      wifi.sta.config("Van den Eede","a123456789")       -- verbinding met router maken
      wifi.sta.connect()
     
     local cnt = 0
     gpio.mode(0,gpio.OUTPUT);
     tmr.alarm(0, 1000, 1, function() 
         if (wifi.sta.getip() == nil) and (cnt < 20) then 
             print("Trying Connect to Router, Waiting...")
             cnt = cnt + 1 
                  if cnt%2==1 then gpio.write(0,gpio.LOW);
                  else gpio.write(0,gpio.HIGH); end
         else 
             tmr.stop(0);
             print("Soft AP started")
             print("Heep:(bytes)"..node.heap());
             print("MAC:"..wifi.ap.getmac().."\r\nIP:"..wifi.ap.getip());
             if (cnt < 20) then print("Conected to Router\r\nMAC:"..wifi.sta.getmac().."\r\nIP:"..wifi.sta.getip())
                 else print("Conected to Router Timeout");
             end
             cnt = nil;cfg=nil;str=nil;ssidTemp=nil;
             collectgarbage()
         end 
     end)

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
        buf = buf.."<h1>Webserver op esp8266</h1>";
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
