sub init()
    m.top.content = CreateObject("roSGNode", "ContentNode")
    m.port = CreateObject("roMessagePort")
end sub

sub onFetchChannels()
    if m.top.fetchChannels = true
        ' Set status to loading
        m.top.status = "loading"

        ' Determine which URL to use
        urlList = ["https://bit.ly/tta-m3u", "https://tinyurl.com/multiservice21?region=all&service=PlutoTV"]

        ' Loop through URLs to fetch data from either one
        for each url in urlList
            urlTransfer = CreateObject("roUrlTransfer")
            urlTransfer.setURL(url)
            urlTransfer.enableEncodings(true)

            ' Set up HTTPS handling if URL is secure
            if Left(url, 5) = "https"
                urlTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
                urlTransfer.addHeader("X-Roku-Reserved-Dev-Id", "")
                urlTransfer.initClientCertificates()
            end if

            ' Fetch the data
            response = urlTransfer.getToString()
            if response <> invalid
                ' Parse the response
                m.top.content = parseChannelData(response)
                m.top.status = "success"
                exit for  ' Exit if successful
            end if
        end for

        ' If no valid data was retrieved, set error status
        if m.top.content.getChildCount() = 0
            m.top.status = "error"
            m.top.errorMessage = "Failed to load channels from both URLs."
        end if

        ' Reset the fetchChannels trigger
        m.top.fetchChannels = false
    end if
end sub

' Function to parse M3U playlist data and create content nodes
function parseChannelData(data as String) as Object
    ' Regular expressions to match M3U format
    reLineSplit = CreateObject("roRegex", "(?>\r\n|[\r\n])", "")
    reExtinf = CreateObject("roRegex", "(?i)^#EXTINF:\s*(\d+|-1|-0).*,\s*(.*)$", "")
    rePath = CreateObject("roRegex", "^([^#].*)$", "")

    inExtinf = false
    title = ""
    con = CreateObject("roSGNode", "ContentNode")

    ' Process each line of the M3U data
    for each line in reLineSplit.Split(data)
        ' Check for #EXTINF line, which contains title info
        maExtinf = reExtinf.Match(line)
        if maExtinf.Count() = 3
            title = maExtinf[2]
            inExtinf = true
        end if

        ' Check for path (URL of the channel stream)
        if inExtinf
            maPath = rePath.Match(line)
            if maPath.Count() = 2
                item = con.CreateChild("ContentNode")
                item.title = title
                item.url = maPath[1]
                item.streamFormat = "hls"
                inExtinf = false  ' Reset flag
            end if
        end if
    end for

    return con
end function
