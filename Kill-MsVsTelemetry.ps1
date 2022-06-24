#
# Script to kill Visual Studio telemetry so MS doesn't spy on maldev efforts
#


$vs_dir = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise"
$vs_regkey_policy = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\VisualStudio"
$vs_regkey_feedback = $vs_regkey_policy + "\Feedback"
$vs_regkey_sqm = $vs_regkey_policy + "\SQM"
$vs_regkey_telem = "HKEY_CURRENT_USER\Software\Microsoft\VisualStudio\Telemetry"


reg add $vs_regkey_feedback /v DisableFeedbackDialog /t REG_DWORD /d 1 /f
reg add $vs_regkey_feedback /v DisableEmailInput /t REG_DWORD /d 1 /f
reg add $vs_regkey_feedback /v DisableScreenshotCapture /t REG_DWORD /d 1 /f
reg add $vs_regkey_sqm /v OptIn /t REG_DWORD /d 0 /f
reg add $vs_regkey_telem /v TurnOffSwitch /t REG_DWORD /d 1 /f


if (test-path ($env:appdata + "\vstelemetry")) {
remove-item -path ($env:appdata + "\vstelemetry") -force -recurse | out-null
}
if (test-path ($env:LocalAppData + "\Microsoft\VSApplicationInsights")) {
remove-item -path ($env:LocalAppData + "\Microsoft\VSApplicationInsights") -force -recurse | out-null
}
if (test-path ($env:ProgramData + "\Microsoft\VSApplicationInsights")) {
remove-item -path ($env:ProgramData + "\Microsoft\VSApplicationInsights") -force -recurse | out-null
}
if (test-path ($env:Temp + "\Microsoft\VSApplicationInsights")) {
remove-item -path ($env:Temp + "\Microsoft\VSApplicationInsights") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSFaultInfo")) {
remove-item -path ($env:Temp + "\VSFaultInfo") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSFeedbackIntelliCodeLogs")) {
remove-item -path ($env:Temp + "\VSFeedbackIntelliCodeLogs") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSFeedbackPerfWatsonData")) {
remove-item -path ($env:Temp + "\VSFeedbackPerfWatsonData") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSFeedbackVSRTCLogs")) {
remove-item -path ($env:Temp + "\VSFeedbackVSRTCLogs") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSRemoteControl")) {
remove-item -path ($env:Temp + "\VSRemoteControl") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSTelem")) {
remove-item -path ($env:Temp + "\VSTelem") -force -recurse | out-null
}
if (test-path ($env:Temp + "\VSTelem.Out")) {
remove-item -path ($env:Temp + "\VSTelem.Out") -force -recurse | out-null
}

$hosts_content = @"

# to kill VS telemetry
127.0.0.1       vortex.data.microsoft.com
127.0.0.1       dc.services.visualstudio.com
127.0.0.1       visualstudio-devdiv-c2s.msedge.net
127.0.0.1       az667904.vo.msecnd.net
127.0.0.1       az700632.vo.msecnd.net
127.0.0.1       sxpdata.microsoft.com
127.0.0.1       sxp.microsoft.com

"@

Add-Content -Value $hosts_content -Path "C:\Windows\System32\drivers\etc\hosts"
