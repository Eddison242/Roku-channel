' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

' Main function to initialize the application and load channels/EPG data
sub Main()

    reg = CreateObject("roRegistrySection", "profile")
    if reg.Exists("primaryfeed") then
        url = reg.Read("primaryfeed")
    else
        ' Default URL for channel feed, replaceable with parsed M3U data
        url = "https://pastebin.com/raw/v0dE8SdX"
    end if

    ' Define M3U and EPG URLs
    m3uUrl = "https://bit.ly/tta-m3u"  ' Your M3U link
    epgUrl = "https://bit.ly/tta-epg"  ' Your EPG link

    ' Parse M3U and EPG data
    channels = ParseM3U(m3uUrl)
    epgData = FetchEPG(epgUrl)

    ' Set up the screen and global data
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    m.global = screen.getGlobalNode()
    m.global.addFields({feedurl: url, channels: channels, epg: epgData})  ' Pass channels and epg data to global node
    scene = screen.CreateScene("MainScene")
    screen.show()

    ' Event loop
    while(true) 
        msg = wait(0, m.port)
        msgType = type(msg)
        print "msgTYPE >>>>>>>>"; type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
    
end sub

' Function to parse M3U playlist and return an array of channels
function ParseM3U(m3uUrl as String) as Object
    channels = []
    response = ParseM3UFile(m3uUrl)

    if response <> invalid
        lines = response.Split(chr(10))
        
        ' Process each line in the M3U file
        for each line in lines
            if line.Left(7) = "#EXTINF"
                ' Extract channel name from the line
                channelName = line.Substring(line.IndexOf(",") + 1).Trim()
                
                ' Next line should contain the URL
                nextLine = lines[lines.index(line) + 1]
                channelUrl = nextLine.Trim()
                
                ' Add the channel details to the array
                channel = {
                    name: channelName
                    url: channelUrl
                }
                channels.Push(channel)
            end if
        end for
    end if

    return channels
end function

' Helper function to fetch and parse the M3U file from the provided URL
function ParseM3UFile(url as String) as String
    port = CreateObject("roMessagePort")
    request = CreateObject("roUrlTransfer")
    request.SetPort(port)
    request.SetUrl(url)

    if request.GetToString() <> invalid
        return request.GetToString()
    end if

    return invalid
end function

' Function to retrieve EPG data from a JSON URL
function FetchEPG(epgUrl as String) as Object
    epgData = invalid
    port = CreateObject("roMessagePort")
    request = CreateObject("roUrlTransfer")
    request.SetPort(port)
    request.SetUrl(epgUrl)

    response = request.GetToString()
    if response <> invalid
        epgData = ParseJSON(response)
    end if

    return epgData
end function
