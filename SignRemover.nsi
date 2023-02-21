/* GSolone 1/12/21
   Credits:
    -
   Icon:
    https://www.iconfinder.com/icons/3215599/brand_brands_logo_logos_outlook_icon
   Modifiche:
    21/2/23- Bugfix: risolvo problema dovuto a backup vuoto delle firme e tengo direttamente la cartella rinominandola con la data in cui viene fatto girare il programma, tolgo di mezzo 7z.
*/

!define PRODUCT_NAME "Outlook Signatures Removal Tool"
!define PRODUCT_VERSION "0.2"
!define PRODUCT_VERSION_MINOR "1.0"
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
VIAddVersionKey LegalTrademarks "GSolone, ${MyTIMESTAMP_Yr}"
VIAddVersionKey OriginalFilename "OutlookSignRemover-${PRODUCT_VERSION}.exe"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "SignatureRemover_${PRODUCT_VERSION}.exe"
InstallDir "$TEMP"
ShowInstDetails show
BrandingText "Emmelibri S.r.l. - GSolone ${MyTIMESTAMP_Yr}"

RequestExecutionLevel User
SpaceTexts none

Section "Pulizia firme da Outlook" SEC_BACKUP
  IfFileExists "$APPDATA\Microsoft\Signatures" 0 Signs_Skip
   DetailPrint "Signatures folder found, I'll rename it now."
   Rename "$APPDATA\Microsoft\Signatures" "$APPDATA\Microsoft\Signatures_Bck${MYTIMESTAMP}"
  Signs_Skip:
SectionEnd