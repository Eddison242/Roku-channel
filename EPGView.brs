' ********** EPGView.brs **********

sub init()
    m.top.functionName = "loadEPG"
    m.backButtonPressed = false
end sub

' **********************************************

sub loadEPG()
    ' Retrieve the EPG data from the global node
    epgData = m.global.epg
    con = CreateObject("roSGNode", "ContentNode")

    ' Check if EPG data is available
    if epgData = invalid or epgData.Count() = 0
        print "No EPG data available"
        return
    end if

    ' Loop through each channel in the EPG data
    for each channel in epgData
        ' Create a ContentNode for each channel's EPG section
        channelNode = con.CreateChild("ContentNode")
        channelNode.contentType = "section"
        channelNode.title = channel.channelName

        ' Loop through each program for the channel
        for each program in channel.programs
            ' Create a ContentNode for each program
            programNode = channelNode.CreateChild("ContentNode")
            programNode.title = program.title
            programNode.description = program.description
            programNode.startTime = program.startTime
            programNode.endTime = program.endTime
        end for
    end for

    ' Set the content node with the EPG data
    m.top.content = con
end sub

' Function to handle the Back button press
sub onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "back"
            closeEPGView()
            return true
        end if
    end if
    return false
end sub

sub closeEPGView()
    ' Check if the back button was pressed already to avoid repeated calls
    if not m.backButtonPressed
        m.backButtonPressed = true
        m.top.close = true
    end if
end sub
