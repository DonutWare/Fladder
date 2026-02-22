# 🚀 Fladder Dev Setup

## 🔧 Requirements

Ensure the following tools are installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
- [Android Studio](https://developer.android.com/studio) (for Android development and emulators)
- [VS Code](https://code.visualstudio.com/) with:
  - Flutter extension
  - Dart extension

Verify your Flutter setup with:

```bash
flutter doctor
```

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/DonutWare/Fladder.git
cd Fladder

# Install dependencies
flutter pub get
```

## 🐧 Linux Dependencies

If you're on **Linux**, install the `mpv` dependency:

```bash
sudo apt install libmpv-dev
```

## 🛠️ Running the App

1. **Connect a device** or launch an emulator.
2. In VS Code:
   - Select the target device (bottom right corner).
   - Press `F5` or go to **Run > Start Debugging**.
   - If prompted, select **"Run Anyway"**.

## ⚙️ Code Generation

Generate build files (e.g., for `json_serializable`, `freezed`, etc.):

```bash
flutter pub run build_runner build
```

> Tip: Use `watch` for continuous builds during development:
```bash
flutter pub run build_runner watch
```
Update localization definitions:
```bash
flutter gen-l10n
```
Format files to spec:
```bash
dart format --line-length 120 ./lib/
```

## 🌐 Using a demo Server
You can use a fake server from Jellyfin.
https://demo.jellyfin.org/stable/web/