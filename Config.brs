
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
    Title: "FXX"
    streamFormat: "m3ua"
    Logo: "https://i.pinimg.com/originals/92/02/79/9202790b87dc02a1af565c4a4eb1a403.png"
    Stream: "https://e3.thetvapp.to/hls/FXXEast.m3u8?token=g1hu_fyS_joPz9chV0EAgA&expires=1704757146"
}
{
    Title: "FX"
    streamFormat: "m3u8"
    Logo: "https://pbs.twimg.com/media/FPSMczbVkAAUfTQ.jpg"
    Stream: "https://e3.thetvapp.to/hls/FXEast.m3u8?token=qZVPdEWE1H19VWrOvDmP_w&expires=1704757422"
}
{
    Title: "Cartoon Network"
    streamFormat: "m3u8"
    Logo: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Cartoon_Network_2010_logo.svg/1200px-Cartoon_Network_2010_logo.svg.png"
    Stream: "https://e1.thetvapp.to/hls/CartoonNetworkEast.m3u8?token=qPZr0QiUC6DU2rnS03c4IA&expires=1704757441"
}
{
    Title: "Cinemax"
    streamFormat: "m3ua"
    Logo: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Cinemax.svg/2560px-Cinemax.svg.png"
    Stream: "https://e3.thetvapp.to/hls/CinemaxEast.m3u8?token=Ycw61YzW1es2dTCofpz-JQ&expires=1704757691"
}
{
    Title: "STARZ"
    streamFormat: "m3ua"
    Logo: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Starz_Cinema_logo.svg/1280px-Starz_Cinema_logo.svg.png"
    Stream: "https://e2.thetvapp.to/hls/StarzEast.m3u8?token=IyQ56hLL2lcCj89WyH86UA&expires=1704757936"
}
{
    Title: "Roku Example 7"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
{
    Title: "Roku Example 8"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
{
    Title: "Roku Example 9"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
{
    Title: "Roku Example 10"
    streamFormat: "mp4"
    Logo: "https://placeholdit.imgix.net/~text?txtsize=33&txt=channel+logo&w=267&h=150"
    Stream: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
}
    
'##### Make sure all Channel content is above this line #####    
    ] 
    return arr
End Function
