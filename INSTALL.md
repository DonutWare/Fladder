# Installation instructions

Platform-specific installation instructions can be found in this document.

*Use the links below to jump to your platform.*

- [Windows](#windows)
- [macOS](#macos)
- [Linux](#linux)
	- [Ubuntu/Debian](#ubuntudebian)
	- [Arch](#arch)
	- [Fedora](#fedora)
- [Android](#android)
	- [Play Store](#play-store)
	- [Manual installation](#manual)
- [iOS](#ios)
	- [Sideloadly](#sideloadly)


## Windows

Download the latest `.zip` file from the [Releases](https://github.com/DonutWare/Fladder/releases) page and extract it somewhere on your PC.

Run `Fladder.exe` to start the application.
## macOS

Todo
## Linux

> [!NOTE]
> Flatpak installation will be available soon (thanks to [this PR](https://github.com/DonutWare/Fladder/pull/125)).

### Ubuntu/Debian

> [!TIP]
> If you experience issues attempting to run Fladder with the process exiting with `libmpv` shared library errors, you may need to install `libmpv-dev` by running `sudo apt install libmpv-dev`.

Download the latest Linux `.zip` file from the [Releases](https://github.com/DonutWare/Fladder/releases) page and extract it somewhere on your computer.

Open a terminal and `cd` to the directory where you extracted Fladder to. Run `./Fladder` to open the application.
### Arch

An AUR package is available for download (thanks to @tam1m).

You can download it using your favourite AUR helper.

[Yay](https://github.com/Jguer/yay): `yay -S fladder-git`<br>
[Paru](https://github.com/Morganamilo/paru): `paru -S fladder-git`

### Fedora

> [!TIP]
> If you experience issues attempting to run Fladder with the process exiting with `libmpv` shared library errors, you may need to install `mpvlibs` by running `yum install mpvlibs`.

Download the latest Linux `.zip` file from the [Releases](https://github.com/DonutWare/Fladder/releases) page and extract it somewhere on your computer.

Open a terminal and `cd` to the directory where you extracted Fladder to. Run `./Fladder` to open the application.

## Android

> [!IMPORTANT]
> This app is currently not compatible with Android TV, however contributions to add support are always appreciated.
### Play Store

This is the recommended way to install Fladder on Android.

<a href='https://play.google.com/store/apps/details?id=nl.jknaapen.fladder&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width=250/></a>
### Manual

If your device can't access the Play Store, you can install Fladder manually.

Download the latest `.apk` file from the [Releases](https://github.com/DonutWare/Fladder/releases) page and save it to your device.

You may need to allow unknown apps to be installed on your device, as this will be disallowed by default.

## iOS

### Sideloadly

> [!NOTE]
> Installing using Sideloadly is the only method of using Fladder on iOS at this time. See [this issue](https://github.com/DonutWare/Fladder/issues/40) for more information.

> [!IMPORTANT]
> This guide assumes you are using an iPhone. iPadOS is not supported by Fladder at this time, however, contributions to add support are always appreciated.

> [!IMPORTANT]
> If you are using Windows, you must install the web versions of iTunes and iCloud (**not the Microsoft Store versions**) before installing Sideloadly. You can download them [here](https://www.apple.com/itunes/download/win64) and [here](https://updates.cdn-apple.com/2020/windows/001-39935-20200911-1A70AA56-F448-11EA-8CC0-99D41950005E/iCloudSetup.exe).

1. Download and install Sideloadly from their [downloads page](https://sideloadly.io/#download).

2. Download the latest iOS IPA file from the [Releases](https://github.com/DonutWare/Fladder/releases) page and save it to your computer.

3. Plug your phone into your computer and open iTunes.

4. Click the device icon in the top left next to the navigation buttons.

5. Ensure **Sync with this iPhone over Wi-Fi** is checked.

6. Click Done, then close iTunes.

7. Open Sideloadly and click the Open IPA button in the top left. Select the IPA you downloaded earlier.

8. Make sure your device is listed under **iDevice**. It will usually look like this: `<device name> (<iOS version>) <UDID> @USB`.

9. Enter your Apple ID in the **Apple ID** box. We recommend creating a second Apple ID, but this is not required.

10. Click Start. You will be prompted to enter your Apple ID password. Enter it and allow any two-factor authentication, if required.

11. The installation process will take a while. Once it's finished, you will see the Fladder icon on your home screen or in your App Library.

> [!NOTE]
> Your password is only used for authentication to Apple's servers. It is not sent to any third parties.

> [!NOTE]
> Once installed, Fladder will only be valid for 7 days. Enabling auto refesh will keep the app from expiring (this should already be enabled). Your computer needs to be on for this to occur.

## Docker

You can install Fladder on your server to provide an alternate Jellyfin dashboard.

Copy the contents of the `docker-compose.yml` file and save it to your server:
```
version: '3.4'

services:
  fladder:
    image: ghcr.io/donutware/fladder:latest
    ports:
      - 80:80
    environment:
      - BASE_URL=https://server-url #OPTIONAL: Locks the Fladder front-end to a certain jellyfin server
```

Run `docker-compose up -d` to start the container. It will be available on `http://<server-ip>`.

> [!TIP]
> We recommend changing the `BASE_URL` environment variable to the URL you use to access Jellyfin, as this will skip entering it when you load the web UI.

