sub init()
    m.top.functionName = "getContent"
end sub

' **********************************************

sub getContent()
    ' Retrieve the parsed channels data from the global node
    channels = m.global.channels

    con = CreateObject("roSGNode", "ContentNode")

    ' Loop through each channel in the parsed M3U data
    for each channel in channels
        ' Create a ContentNode for each channel and set its properties
        item = con.CreateChild("ContentNode")
        item.url = channel.url
        item.title = channel.name
    end for

    ' Set the content node with the list of channels
    m.top.content = con
end sub
