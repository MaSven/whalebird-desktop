# whalebird

Whalebird is a mastodon client for desktop application. If you want to use release build, please download from [release page](https://github.com/h3poteto/whalebird-desktop/releases).

## Feature

- Slack like interface
- Notify to desktop
- Streaming
- Many keyboard shortcuts
- Manage multiple accounts

## Install
### Mac

Download from [release page](https://github.com/h3poteto/whalebird-desktop/releases), and to decompress. I recommend that you move `whalebird.app` to `/Applications`.

Please wait for distribute in Mac app store, I'm preparing.

### Linux

Download from [release page](https://github.com/h3poteto/whalebird-desktop/releases), and to decompress. I'm preparing deb and rmp packages.

### Windows

TODO.
Please wait...

## Development

``` bash
# clone this repository
$ git clone https://github.com/h3poteto/whalebird-desktop.git
$ cd whalebird-desktop

# install dependencies
$ npm install

# serve with hot reload at localhost:9080
$ npm run dev
```

## Release
### packaging

I prepared Makefile for production release.

```bash
# for linux
$ make VERSION=0.1.0 PLATFORM=linux

# for mac
$ make VERSION=0.1.0 PLATFORM=darwin CERTNAME="Develper ID Application: NAME (ID)"
```

### App Store

Create release package.

```bash
# for app store
$ make store VERSION=0.1.0 PLATFORM=mas CERTNAME="3rd Party Mac Developer Application: NAME (ID)"
```

And add the follwing code in `packages/whalebird-mas-x64/whalebird.app/Contents/Info.plist`:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
...
    <key>ElectronTeamID</key>
    <string>TeamID</string>
  </dict>
</plist>
```

You can find TeamID on your Apple developer account.

After that, create pkg.

```bash
$ ./packageAppStore.sh ./packages/whalebird-mas-x64/whalebird.app "3rd Party Mac Developer Application: NAME (ID)" "3rd Party Mac Developer Installer: NAME (ID)"
```

# License
The software is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
