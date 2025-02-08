[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{768C5CDE-8FC8-4AB3-9AED-BE126745FF90}
AppName="Fladder"
AppVersion={%FLADDER_VERSION|latest}
;AppVerName=Fladder {#MyAppVersion}
AppPublisher="DonutWare"
AppPublisherURL="https://github.com/DonutWare/Fladder"
AppSupportURL="https://github.com/DonutWare/Fladder"
AppUpdatesURL="https://github.com/DonutWare/Fladder"
DefaultDirName={autopf}\Fladder
; "ArchitecturesAllowed=x64compatible" specifies that Setup cannot run
; on anything but x64 and Windows 11 on Arm.
ArchitecturesAllowed=x64compatible
; "ArchitecturesInstallIn64BitMode=x64compatible" requests that the
; install be done in "64-bit mode" on x64 or Windows 11 on Arm,
; meaning it should use the native 64-bit Program Files directory and
; the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64compatible
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputBaseFilename=fladder_setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\fladder.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\desktop_drop_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\dynamic_color_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\ffmpeg-7.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\fvp_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\isar.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\isar_flutter_libs_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\libass.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\local_auth_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\mdk.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\media_kit_video_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\screen_brightness_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\screen_retriever_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\share_plus_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\smtc_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\window_manager_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Fladder\Fladder\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\Fladder"; Filename: "{app}\fladder.exe"
Name: "{autodesktop}\Fladder"; Filename: "{app}\fladder.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\fladder.exe"; Description: "{cm:LaunchProgram,Fladder}"; Flags: nowait postinstall skipifsilent

