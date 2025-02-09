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

SetupIconFile="D:\a\Fladder\Fladder\icons\production\fladder_icon.ico"
LicenseFile="D:\a\Fladder\Fladder\LICENSE"
WizardImageFile=D:\a\Fladder\Fladder\assets\windows-installer\fladder-installer-100.bmp,D:\a\Fladder\Fladder\assets\windows-installer\fladder-installer-125.bmp,D:\a\Fladder\Fladder\assets\windows-installer\fladder-installer-150.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\fladder.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-console-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-console-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-datetime-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-debug-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-errorhandling-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-fibers-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-file-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-file-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-file-l2-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-handle-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-heap-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-interlocked-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-libraryloader-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-localization-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-memory-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-namedpipe-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-processenvironment-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-processthreads-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-processthreads-l1-1-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-profile-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-rtlsupport-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-string-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-synch-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-synch-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-sysinfo-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-timezone-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-core-util-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-conio-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-convert-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-environment-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-filesystem-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-heap-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-locale-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-math-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-multibyte-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-private-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-process-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-runtime-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-stdio-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-string-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-time-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-crt-utility-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-downlevel-kernel32-l2-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\api-ms-win-eventing-provider-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\concrt140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\d3dcompiler_47.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\desktop_drop_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\dynamic_color_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\ffmpeg-7.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\fvp_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\isar.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\isar_flutter_libs_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\libass.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\libc++.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\libEGL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\libGLESv2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\libmpv-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\local_auth_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\mdk.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\media_kit_libs_windows_video_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\media_kit_video_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\msvcp140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\msvcp140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\msvcp140_2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\msvcp140_atomic_wait.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\msvcp140_codecvt_ids.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\screen_brightness_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\screen_retriever_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\share_plus_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\smtc_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\ucrtbase.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\ucrtbased.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vccorlib140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vccorlib140d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vcruntime140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vcruntime140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vcruntime140_1d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vcruntime140d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vk_swiftshader.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\vulkan-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\window_manager_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\zlib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\a\Fladder\Fladder\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Fladder"; Filename: "{app}\fladder.exe"
Name: "{autodesktop}\Fladder"; Filename: "{app}\fladder.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\fladder.exe"; Description: "{cm:LaunchProgram,Fladder}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: {localappdata}\DonutWare