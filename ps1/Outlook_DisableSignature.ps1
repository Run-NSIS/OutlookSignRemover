# GSolone 2023
# https://gioxx.org | https://github.com/gioxx
New-ItemProperty -path
"HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" -Name
"DisableSignatures" -Value '1' -PropertyType 'DWORD' -Force