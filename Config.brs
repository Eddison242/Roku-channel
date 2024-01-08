
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

Function loadConfig() as Object
    arr = [
'##### Format for inputting stream info #####
'## For each channel, enclose in brackets ## 
'{
'   Title: Channel Title
'   streamFormat: Channel stream type (ex. "hls", "ism", "mp4", etc..)
'   Logo: Channel Logo (ex. "http://Roku.com/Roku.jpg)
'   Stream: URL to stream (ex. http://hls.Roku.com/talks/xxx.m3u8)
'}
    
{
    Title: "robot chicken"
    streamFormat: "m3u8"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://manifest.auditude.com/auditude/variant/live36acbd2cde9e522261fca654762a8f3320419cc2/aHR0cHM6Ly9hZHVsdHN3aW0tdm9kbGl2ZS5jZG4udHVybmVyLmNvbS9saXZlL3JvYm90LWNoaWNrZW4vc3RyZWFtX2RlLm0zdTg/aGRudHM9.m3u8?__sid__=live36acbd2cde9e522261fca654762a8f3320419cc2:1704731996992&g=1000015&k=_fw_ae=725bd42fc9c9394e790b9a73610da431;stream=AS-desktop-streams;caid=live36acbd2cde9e522261fca654762a8f3320419cc2;vdur=0;_fw_ar=0;idfa=084D2F97-D6A5-41C6-90BB-4CDDE192ACBB;_fw_us_privacy=;_fw_gdpr=0;_fw_gdpr_consent=&live=true&ptassetid=live36acbd2cde9e522261fca654762a8f3320419cc2&ptcueformat=turner&ptdebug=false&pttoken=true&pttrackingversion=v2&u=ac217921a4a853e52310ebc459eef367&z=131829"
}
{
    Title: "adult swim mp4"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://adultswimtv.warnermediacdn.com/hls/live/2007031/livestream/master_Layer7.m3u8"
}
{
    Title: "adult swim"
    streamFormat: "m3u8"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://adultswimtv.warnermediacdn.com/hls/live/2007031/livestream/master_Layer7.m3u8"
}
{
    Title: "Roku Example Four"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
{
    Title: "Roku Example Five"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
{
    Title: "Roku Example Six"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
    
    
    
'##### Make sure all Channel content is above this line #####    
    ] 
    return arr
End Function
