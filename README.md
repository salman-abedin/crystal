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

-  A **Compositor**(duh!)
-  **xdo**
-  **wmctrl**

## Prerequisites

-  Get the **WM_NAME** of your status bar using **xprop** and change the **STATUS_BAR** variable in the script accordingly

## Installation

```sh
git clone git@github.com:salman-abedin/crystal.git
sudo make install
```

## Usage

- This is shellscript, so do the typical drill (chmod, move to path)

```sh
crystal --toggle [monocle,fullscreen]  # toggle crystal mode
crystal --navigate [next,prev]         # navigate to next/prev hidden windows
crystal --close                        # closes current window and focuses on the previous one
```

## Uninstallation

```sh
sudo make uninstall
```

## Other Projects

[Bolt](https://github.com/salman-abedin/bolt)
: The lightning fast workflow creator

[Uniblocks](https://github.com/salman-abedin/uniblocks)
: The statusbar

[Magpie](https://github.com/salman-abedin/magpie)
: The dotfiles

## Contact

SalmanAbedin@disroot.org
