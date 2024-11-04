' ********** EPGView.brs **********
sub init()
    m.port = CreateObject("roMessagePort")
    m.epgList = m.top.FindNode("epgList")
    m.backButton = m.top.FindNode("backButton")

    ' Observe back button for events
    m.backButton.ObserveField("buttonSelected", "onBackButtonPress")

    fetchEPGData() ' Fetch EPG data
end sub

sub fetchEPGData()
    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.setURL(m.global.epgUrl) ' EPG URL
    urlTransfer.setMessagePort(m.port)
    urlTransfer.asyncGetToString()
end sub

sub onMessageReceived()
    msg = wait(0, m.port)
    if type(msg) = "roUrlEvent"
        if msg.getResponseCode() = 200
            epgXml = msg.getString()
            processEPGData(epgXml)
        else
            print "Error fetching EPG data: " + msg.getResponseCode()
            showError("Failed to load EPG data.")
        end if
    end if
end sub

sub processEPGData(epgXml as String)
    ' Initialize EPG list
    m.epgList.content = CreateObject("roSGNode", "ContentNode")
    
    xmlParser = CreateObject("roXmlElement")
    xmlParser.parse(epgXml)

    ' Loop through channels and programs
    for each channel in xmlParser.getChildren()
        if channel.nodeType = "element" and channel.getName() = "channel"
            channelName = channel.getChild("display-name").getValue()
            programsNode = channel.getChild("programme")

            channelNode = m.epgList.content.CreateChild("ContentNode")
            channelNode.title = channelName
            channelNode.id = channelName

            ' Add programs under the channel
            for each program in programsNode
                programNode = channelNode.CreateChild("ContentNode")
                programNode.title = program.getChild("title").getValue()
                programNode.description = program.getChild("desc").getValue()
                programNode.startTime = program.getAttribute("start")
                programNode.endTime = program.getAttribute("end")
            end for

            m.epgList.content.AppendChild(channelNode)
        end if
    end for

    m.epgList.SetFocus(true) ' Set focus on the EPG list
end sub

sub onBackButtonPress()
    ' Handle back button press
    if m.backButton.buttonSelected = 0 ' Assuming the first button is the back button
        m.top.visible = false ' Hide EPG view
        m.top.FindNode("MainScene").visible = true ' Show main scene
    end if
end sub

sub showError(message as String)
    ' Display an error message (you might want to create a dialog node for this)
    print message
end sub
