
-- code die momenteel niet gebruikt wordt voor de app

if(_GET.titels) then

            --conn:send("HTTP/1.0 200 OK\n")
            --conn:send("Server: ESP (Wireless jukebox)\n")
            --conn:send("Content-Type: application/json")
            --conn:send("Content-Length: 1\n\n")
            
            --client:send('[');
            --client:send('{ "Titel" : "' .. songTitle1 .. ' ", "Stemmen" : "' .. song1 .. '"},')
            --client:send('{ "Titel" : "' .. songTitle2 .. ' ", "Stemmen" : "' .. song2 .. '"},')
            --client:send('{ "Titel" : "' .. songTitle3 .. ' ", "Stemmen" : "' .. song3 .. '"},')
            --client:send('{ "Titel" : "' .. songTitle4 .. ' ", "Stemmen" : "' .. song4 .. '"}' )
            --client:send(']')

        else
            -- We openen de file en sturen het lijn per lijn naar de client
            --conn:send("HTTP/1.1 200 OK\n")
            --conn:send("Server: ESP (Wireless jukebox)\n")