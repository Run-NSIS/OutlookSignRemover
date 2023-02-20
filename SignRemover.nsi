/* GSolone 1/12/21
   Modifiche:
    -
*/

!define PRODUCT_NAME "Outlook Signatures Removal Tool"
!define PRODUCT_VERSION "0.2"
!define PRODUCT_PUBLISHER "Gioxx"
!define PRODUCT_WEB_SITE "https://gioxx.org"

!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "include\Outlook_41132.ico"
!define /date MYTIMESTAMP "%Y%m%d-%H%M%S"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "Italian"

VIProductVersion "${PRODUCT_VERSION}.0.0"
VIAddVersionKey ProductName "${PRODUCT_NAME}"
VIAddVersionKey Comments "A build of ${PRODUCT_NAME}. For additional details, visit gioxx.org"
VIAddVersionKey CompanyName Gioxx.org
VIAddVersionKey LegalCopyright Gioxx.org
VIAddVersionKey FileDescription "${PRODUCT_NAME}"
VIAddVersionKey FileVersion ${PRODUCT_VERSION}
VIAddVersionKey ProductVersion ${PRODUCT_VERSION}
VIAddVersionKey InternalName "${PRODUCT_VERSION}"
VIAddVersionKey LegalTrademarks "Gioxx, 2021"
VIAddVersionKey OriginalFilename "OutlookSignRemover-${PRODUCT_VERSION}.exe"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "SignatureRemover-${PRODUCT_VERSION}.exe"
InstallDir "$TEMP"
ShowInstDetails show
BrandingText "https://gioxx.org - GSolone 2021" # https://nsis-dev.github.io/NSIS-Forums/html/t-222077.html

RequestExecutionLevel User

Section "Backup delle firme esistenti" SEC01
  CreateDirectory "$TEMP\OutlookSignatures"
  SetOutPath $TEMP
  File "Include\7za.exe"
  System::Call "advapi32::GetUserName(t .r0, *i ${NSIS_MAX_STRLEN} r1) i.r2"
  nsExec::Exec  '"$TEMP\7za.exe" a  "$TEMP\OutlookSignatures\Signs_$0_${MYTIMESTAMP}.7z" "$APPDATA\Microsoft\Signatures"'
  CopyFiles "$TEMP\OutlookSignatures\Signs_*.7z" "C:\Users\$0\"
SectionEnd

Section "Rimozione delle firme" SEC02
  RmDir /r "$APPDATA\Microsoft\Signatures\*"
SectionEnd

Section -Post
  Delete "$TEMP\7za.exe"
  RMDir /r "$TEMP\OutlookSignatures"
  ;SetAutoClose true
SectionEnd