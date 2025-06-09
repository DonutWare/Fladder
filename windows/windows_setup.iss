#define SourcePath ".."

[Setup]
AppId={{D573EDD5-117A-47AD-88AC-62C8EBD11DC7}
AppName="Fladder"
AppVersion={%FLADDER_VERSION|latest}
AppPublisher="DonutWare"
AppPublisherURL="https://github.com/DonutWare/Fladder"
AppSupportURL="https://github.com/DonutWare/Fladder"
AppUpdatesURL="https://github.com/DonutWare/Fladder"
DefaultDirName={localappdata}\Programs\Fladder
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputBaseFilename=fladder_setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

SetupLogging=yes
UninstallLogging=yes
UninstallDisplayName="Fladder"
UninstallDisplayIcon={app}\fladder.exe
SetupIconFile="{#SourcePath}\icons\production\fladder_icon.ico"
LicenseFile="{#SourcePath}\LICENSE"
WizardImageFile="{#SourcePath}\assets\windows-installer\fladder-installer-100.bmp", \
                "{#SourcePath}\assets\windows-installer\fladder-installer-125.bmp", \
                "{#SourcePath}\assets\windows-installer\fladder-installer-150.bmp"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#SourcePath}\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Fladder"; Filename: "{app}\fladder.exe"
Name: "{autodesktop}\Fladder"; Filename: "{app}\fladder.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\fladder.exe"; Description: "{cm:LaunchProgram,Fladder}"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall:
      begin
        if MsgBox('Would you like to delete the application''s data? This action cannot be undone. Synced files will remain unaffected.', mbConfirmation, MB_YESNO) = IDYES then
        begin
            if DelTree(ExpandConstant('{localappdata}\DonutWare'), True, True, True) = False then
            begin
                Log(ExpandConstant('{localappdata}\DonutWare could not be deleted. Skipping...'));
            end;
        end;
      end;
  end;
end;
