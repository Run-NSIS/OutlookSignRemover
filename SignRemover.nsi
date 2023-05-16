/* GSolone 1/12/21
   Credits:
    https://legacy.support.exclaimer.com/hc/en-gb/articles/360044101112-How-to-disable-the-Microsoft-Outlook-Roaming-Signatures-feature
   Icon:
    https://www.iconfinder.com/icons/3215599/brand_brands_logo_logos_outlook_icon
   Modifiche:
    16/5/23- Change: porto a bordo del software le modifiche al registro per disattivare il pannello firme (locale) e le nuove roaming signatures di Microsoft 365.
    21/2/23- Bugfix: risolvo problema dovuto a backup vuoto delle firme e tengo direttamente la cartella rinominandola con la data in cui viene fatto girare il programma, tolgo di mezzo 7z.
*/

!define PRODUCT_NAME "Outlook Signatures Removal Tool"
!define PRODUCT_VERSION "0.3"
!define PRODUCT_VERSION_MINOR "0.0"
!define PRODUCT_PUBLISHER "Emmelibri S.r.l."
!define PRODUCT_WEB_SITE "https://www.emmelibri.it"
!define PRODUCT_BUILD "${PRODUCT_NAME} ${PRODUCT_VERSION}.${PRODUCT_VERSION_MINOR} (build ${MyTIMESTAMP})"

!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "include\3215599_brand_brands_logo_logos_outlook_icon(1).ico"
!define /date MYTIMESTAMP "%Y%m%d-%H%M%S"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "Italian"
!define /date MyTIMESTAMP_Yr "%Y"

VIProductVersion "${PRODUCT_VERSION}.${PRODUCT_VERSION_MINOR}"
VIAddVersionKey ProductName "${PRODUCT_NAME}"
VIAddVersionKey Comments "${PRODUCT_NAME}"
VIAddVersionKey CompanyName "Emmelibri S.r.l."
VIAddVersionKey LegalCopyright GSolone
VIAddVersionKey FileDescription "Remove all signatures from Outlook."
VIAddVersionKey FileVersion ${PRODUCT_VERSION}
VIAddVersionKey ProductVersion ${PRODUCT_VERSION}
VIAddVersionKey InternalName "${PRODUCT_VERSION}"
VIAddVersionKey LegalTrademarks "GSolone, 2021"
VIAddVersionKey OriginalFilename "OutlookSignRemover-${PRODUCT_VERSION}.exe"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "SignatureRemover_${PRODUCT_VERSION}.exe"
InstallDir "$TEMP"
ShowInstDetails show
BrandingText "Emmelibri S.r.l. - GSolone ${MyTIMESTAMP_Yr}"

RequestExecutionLevel User
SpaceTexts none

Section "Pulizia firme da Outlook (locale)" SEC_BACKUP
  IfFileExists "$APPDATA\Microsoft\Signatures" 0 Signs_Skip
   DetailPrint "Signatures folder found, I'll rename it now."
   Rename "$APPDATA\Microsoft\Signatures" "$APPDATA\Microsoft\Signatures_Bck${MYTIMESTAMP}"
  Signs_Skip:
SectionEnd

Section "Blocco pannello firme Outlook (locale)" SEC_STOPLOCALSIGN
 ReadRegDword $0 HKCU "SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" "DisableSignatures"
 IfErrors DSDoesntExist DSExists
  DSDoesntExist:
   ClearErrors
   DetailPrint "DisableSignatures not found, I'll create it now."
   WriteRegDword HKCU "SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" "DisableSignatures" 0x00000001
   Goto DSEnd
  DSExists:
   DetailPrint "DisableSignatures found, value $0."
   StrCmp $0 0 0 DSEnd
    DetailPrint "I'm changing the value of the key to 1."
    WriteRegDword HKCU "SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" "DisableSignatures" 0x00000001
    Goto DSEnd
  DSEnd:
   DetailPrint "DisableSignatures value: $0"
SectionEnd

Section "Blocco firme Outlook in roaming (M365)" SEC_STOPROAMINGSIGN
 ReadRegDword $0 HKCU "Software\Microsoft\Office\16.0\Outlook\Setup" "DisableRoamingSignaturesTemporaryToggle"
 IfErrors DRSTTDoesntExist DRSTTExists
  DRSTTDoesntExist:
   ClearErrors
   DetailPrint "DRSTT not found, I'll create it now."
   WriteRegDword HKCU "Software\Microsoft\Office\16.0\Outlook\Setup" "DisableRoamingSignaturesTemporaryToggle" 0x00000001
   Goto DRSTTEnd
  DRSTTExists:
   DetailPrint "DRSTT found, value $0."
   StrCmp $0 0 0 DRSTTEnd
    DetailPrint "I'm changing the value of the key to 1."
    WriteRegDword HKCU "Software\Microsoft\Office\16.0\Outlook\Setup" "DisableRoamingSignaturesTemporaryToggle" 0x00000001
    Goto DRSTTEnd
  DRSTTEnd:
   DetailPrint "DRSTT value: $0"
SectionEnd