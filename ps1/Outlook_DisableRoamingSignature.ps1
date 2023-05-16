# GSolone 2023
# https://gioxx.org | https://github.com/gioxx
New-ItemProperty -path
"HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup" -Name
"DisableRoamingSignaturesTemporaryToggle" -Value '1' -PropertyType 'DWORD' -Force