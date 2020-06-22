![](demo/preview.gif)

# Window manager agnostic clear transparent workflow for Unix

No more ugly windows behind your beautiful transparent one

## Features

-  Can be used on any window manager
-  No background windows on fullscreen mode
-  No background windows on monocle mode
-  Navigation between hidden windows
-  Auto navigate to previews hidden window after closing

## Dependencies

-  head, tail, xargs, shift
-  A compositor( ex. **xcompmgr, picom** etc )
-  **xdo**
-  **wmctrl**

## Prerequisites

Get the **WM_NAME** of your status bar using **xprop** and create an environment variable named **STATUSBAR** accordingly. For example, put this in your **.profile/.xprofile** if you are using polybar
`sh export STATUSBAR=polybar`

## Installation

```sh
git clone https://github.com/salman-abedin/crystal.git && cd crystal && sudo make install
```

## Usage

Bind these commands to your preferred key combinations

```sh
crystal --toggle [solo,fullscreen]  # toggle crystal mode
crystal --navigate [next,prev]      # navigate between hidden windows
crystal --close                     # closes the current window and focuses on the previous one
```

## Uninstallation

```sh
sudo make uninstall
```

## FAQ

### What if I change my status bar?

Change the **STATUS_BAR** environment variable and you are good to go.

## Other Projects

[Bolt](https://github.com/salman-abedin/bolt)
: The lightning fast workflow creator

[Uniblocks](https://github.com/salman-abedin/uniblocks)
: The statusbar

[Magpie](https://github.com/salman-abedin/magpie)
: The dotfiles

[Alfred](https://github.com/salman-abedin/alfred)
: The scripts

[Devour](https://github.com/salman-abedin/devour)
: Terminal swallowing

## Contact

SalmanAbedin@disroot.org
