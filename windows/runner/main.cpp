#include <app_links/app_links_plugin_c_api.h>
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include <string>

#include "flutter_window.h"
#include "utils.h"

namespace {

constexpr const wchar_t kMainWindowClassName[] = L"FLUTTER_RUNNER_WIN32_WINDOW";

bool HasDeepLinkArgument(const std::vector<std::string>& arguments) {
  for (const auto& argument : arguments) {
    if (argument.rfind("fladder:", 0) == 0) {
      return true;
    }
  }
  return false;
}

std::wstring GetProcessImagePath(DWORD process_id) {
  HANDLE process =
      ::OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, process_id);
  if (process == nullptr) {
    return L"";
  }
  wchar_t path[MAX_PATH];
  DWORD size = MAX_PATH;
  std::wstring result;
  if (::QueryFullProcessImageNameW(process, 0, path, &size)) {
    result.assign(path, size);
  }
  ::CloseHandle(process);
  return result;
}

HWND FindRunningInstanceWindow() {
  struct SearchState {
    std::wstring executable;
    HWND window = nullptr;
  } state{GetProcessImagePath(::GetCurrentProcessId())};

  ::EnumWindows(
      [](HWND hwnd, LPARAM lparam) -> BOOL {
        auto* state = reinterpret_cast<SearchState*>(lparam);
        wchar_t class_name[64];
        if (::GetClassNameW(hwnd, class_name, 64) == 0 ||
            wcscmp(class_name, kMainWindowClassName) != 0) {
          return TRUE;
        }
        DWORD process_id = 0;
        ::GetWindowThreadProcessId(hwnd, &process_id);
        if (process_id == ::GetCurrentProcessId() ||
            _wcsicmp(GetProcessImagePath(process_id).c_str(),
                     state->executable.c_str()) != 0) {
          return TRUE;
        }
        state->window = hwnd;
        return FALSE;
      },
      reinterpret_cast<LPARAM>(&state));

  return state.window;
}

bool ForwardDeepLinkToRunningInstance(
    const std::vector<std::string>& arguments) {
  if (!HasDeepLinkArgument(arguments)) {
    return false;
  }
  HWND window = FindRunningInstanceWindow();
  if (window == nullptr) {
    return false;
  }
  SendAppLink(window);
  ::ShowWindow(window, ::IsIconic(window) ? SW_RESTORE : SW_SHOW);
  ::SetForegroundWindow(window);
  return true;
}

}

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  if (ForwardDeepLinkToRunningInstance(command_line_arguments)) {
    ::CoUninitialize();
    return EXIT_SUCCESS;
  }

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"Fladder", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
