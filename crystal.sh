#!/usr/bin/env sh

###############################################################################
#                             Config
###############################################################################

# Status Bar
[ "$STATUSBAR" ] || export STATUSBAR=polybar

# BSPWM Specific settings
top_padding=35
bspc config borderless_monocle true
bspc config gapless_monocle true

###############################################################################
#                             Script
###############################################################################

WORKSPACE=/tmp/crystal_0$(wmctrl -d | grep "\*" | cut -d ' ' -f 1)

while :; do
    case $1 in
        --navigate)
            shift
            # window=$(xdo id -rd | head -1)
            if [ "$1" = "next" ]; then
                window=$(xdo id -rd | tail -1)
                # ! grep next "$WORKSPACE" && echo next >> "$WORKSPACE" && window=$(xdo id -rd | tail -1)

            else
                window=$(xdo id -rd | head -1)
                # grep next "$WORKSPACE" && sed -i 's/next//' "$WORKSPACE" && window=$(xdo id -rd | tail -1)

            fi
            if grep solo "$WORKSPACE" && xdo id -rd; then
                xdo hide
                xdo show "$window"
            else
                xdo activate "$window"
            fi
            ;;
        --toggle)
            if grep solo "$WORKSPACE"; then
                sed -i 's/solo//' "$WORKSPACE"
                xdo id -rd && xdo id -rd | xargs xdo show
                bspc desktop -l tiled
                if [ "$2" = "fullscreen" ]; then
                    xdo show -a $STATUSBAR
                    bspc config top_padding $top_padding
                fi
            else
                echo solo >> "$WORKSPACE"
                xdo id -rd && xdo id -rd | xargs xdo hide
                bspc desktop -l monocle
                if [ "$2" = "fullscreen" ]; then
                    xdo hide -a $STATUSBAR
                    bspc config top_padding 0
                fi
            fi
            # $0 --navigate prev
            xdo id -rd | head -1 | xargs xdo activate
            # bspc node -f prev.local
            bspc node -n biggest.local
            ;;

        --close)
            xdo close
            if grep solo "$WORKSPACE"; then
                if xdo id -rd; then
                    xdo id -rd | head -1 | xargs xdo show
                else
                    xdo show -a $STATUSBAR
                    bspc config top_padding $top_padding
                fi
            fi
            ;;
        *) : ;;
    esac
    shift
done
