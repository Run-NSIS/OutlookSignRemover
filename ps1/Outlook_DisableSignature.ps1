New-ItemProperty -path
"HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" -Name
"DisableSignatures" -Value '1' -PropertyType 'DWORD' -Force