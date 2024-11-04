sub init()
    m.top.backgroundURI = "pkg:/images/background-controls.jpg"

    m.save_feed_url = m.top.FindNode("save_feed_url")  ' Save URL to registry

    m.get_channel_list = m.top.FindNode("get_channel_list") ' Get URL from registry and parse the feed
    m.get_channel_list.ObserveField("content", "SetContent") ' Observe content to display the list

    m.list = m.top.FindNode("list")
    m.list.ObserveField("itemSelected", "setChannel") 

    m.video = m.top.FindNode("Video")
    m.video.ObserveField("state", "checkState")

    m.epgButton = m.top.FindNode("epgButton")  ' Assuming you have an EPG button node to launch the EPG view
    m.epgButton.ObserveField("buttonSelected", "showEPGView")

    showdialog()  ' Force a keyboard dialog  
End sub

' **************************************************************

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    
    if press then
        if key = "right"
            m.list.SetFocus(false)
            m.top.SetFocus(true)
            m.video.translation = [0, 0]
            m.video.width = 0
            m.video.height = 0
            result = true
        else if key = "left"
            m.list.SetFocus(true)
            m.video.translation = [800, 100]
            m.video.width = 960
            m.video.height = 540
            result = true
        else if key = "back"
            ' Check if in EPG mode, if so, close the EPG view
            if m.top.FindNode("epgView") <> invalid
                hideEPGView()
            else
                m.list.SetFocus(true)
                m.video.translation = [800, 100]
                m.video.width = 960
                m.video.height = 540
            end if
            result = true
        else if key = "options"
            showdialog()
            result = true
        end if
    end if
    
    return result 
end function

' Handle the EPG button to open the EPG view
sub showEPGView()
    m.epgView = m.top.CreateChild("EPGView")
    m.top.appendChild(m.epgView)
end sub

' Hide the EPG view on back button press
sub hideEPGView()
    if m.epgView <> invalid then
        m.epgView.RemoveChild(m.epgView)
    end if
end sub

sub checkState()
    state = m.video.state
    if state = "error" then
        m.top.dialog = CreateObject("roSGNode", "Dialog")
        m.top.dialog.title = "Error: " + str(m.video.errorCode)
        m.top.dialog.message = m.video.errorMsg
    end if
end sub

sub SetContent()    
    m.list.content = m.get_channel_list.content
    m.list.SetFocus(true)
end sub

sub setChannel()
    if m.list.content.getChild(0).getChild(0) = invalid
        content = m.list.content.getChild(m.list.itemSelected)
    else
        itemSelected = m.list.itemSelected
        for i = 0 to m.list.currFocusSection - 1
            itemSelected = itemSelected - m.list.content.getChild(i).getChildCount()
        end for
        content = m.list.content.getChild(m.list.currFocusSection).getChild(itemSelected)
    end if

    ' Set supported content types
    content.streamFormat = "hls, mp4, mkv, mp3, avi, m4v, ts, mpeg-4, flv, vob, ogg, ogv, webm, mov, wmv, asf, amv, mpg, mp2, mpeg, mpe, mpv, mpeg2"

    if m.video.content <> invalid and m.video.content.url = content.url then return

    content.HttpSendClientCertificates = true
    content.HttpCertificatesFile = "common:/certs/ca-bundle.crt"
    m.video.EnableCookies()
    m.video.SetCertificatesFile("common:/certs/ca-bundle.crt")
    m.video.InitClientCertificates()

    m.video.content = content

    m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"
    m.video.trickplaybarvisibilityauto = false

    m.video.control = "play"
end sub

sub showdialog()
    PRINT ">>>  ENTERING KEYBOARD <<<"

    keyboarddialog = CreateObject("roSGNode", "KeyboardDialog")
    keyboarddialog.backgroundUri = "pkg:/images/rsgde_bg_hd.jpg"
    keyboarddialog.title = "ENTER PLAYLIST HERE"

    keyboarddialog.buttons=["OK","Set back to Demo", "Save"]
    keyboarddialog.optionsDialog=true

    m.top.dialog = keyboarddialog
    m.top.dialog.text = m.global.feedurl
    m.top.dialog.keyboard.textEditBox.cursorPosition = len(m.global.feedurl)
    m.top.dialog.keyboard.textEditBox.maxTextLength = 300

    keyboarddialog.ObserveFieldScoped("buttonSelected", "onKeyPress")  ' Observe button selection
end sub

sub onKeyPress()
    if m.top.dialog.buttonSelected = 0 ' OK
        url = m.top.dialog.text
        m.global.feedurl = url
        m.save_feed_url.control = "RUN"
        m.top.dialog.close = true
        m.get_channel_list.control = "RUN"
    else if m.top.dialog.buttonSelected = 1 ' Set back to Demo
        m.top.dialog.text = "https://tinyurl.com/yaoc6zpo"
    else if m.top.dialog.buttonSelected = 2 ' Save
        m.global.feedurl = m.top.dialog.text
        m.save_feed_url.control = "RUN"
    end if
end sub
