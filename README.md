[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

# i3win

Keyboard shortcuts commonly used in i3wm ported to windows using AutoHotkey.

## Features

- Fast desktop switching
- Moving windows between desktops
- Quick launch terminal

## Installation

Installing i3win requires:

- AutoHotkey is installed and in %PATH%

```cmd
  git clone https://github.com/hsteinmetz/i3win.git
  cd i3win
  AutoHotkey .\i3win.ahk
```

To enable the script on startup, run `create_autostart.ps1` from a powershell with elevated privilege.

## Usage

Currently only `Win` is supported as modkey.

`Win + <n>`: Switch to nth desktop  
`Win + Shift + <n>`: Move current window to nth workspace  
`Win + f`: Maximise current window  
`Win + Shift + q`: Kill current window  
`Win + Enter`: Launch Terminal
`Win + a`: Take Screenshot

## Roadmap

- Switch window focus using i,j,k,l
- Window resizing
- Customisable modkey
- Dynamic reload
- Config file

## Authors

- [@hsteinmetz](https://www.github.com/hsteinmetz)

## Acknowledgements

- [VirtualDesktopAccessor](https://github.com/Ciantic/VirtualDesktopAccessor) by Ciantic

## License

[MIT](https://choosealicense.com/licenses/mit/)
