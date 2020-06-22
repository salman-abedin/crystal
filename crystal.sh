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

MODE=/tmp/crystal_0$(wmctrl -d | grep "\*" | cut -d ' ' -f 1)
dir=/tmp/"$MODE"_prev

case $1 in

    --navigate)
        if [ "$2" = "next" ]; then
            window=$(xdo id -rd | tail -1)
        else
            window=$(xdo id -rd | head -1)
        fi

        if [ -s "$MODE" ] && xdo id -rd; then
            xdo hide
            xdo show "$window"
        else
            xdo activate "$window"
        fi

        ;;

    --toggle)
        if [ -s "$MODE" ]; then
            : > "$MODE"
            xdo id -rd && xdo id -rd | xargs xdo show
            bspc desktop -l tiled
            if [ "$2" = "fullscreen" ]; then
                xdo show -a $STATUSBAR
                bspc config top_padding $top_padding
            fi
        else
            echo mono > "$MODE"
            xdo id -rd && xdo id -rd | xargs xdo hide
            bspc desktop -l monocle
            if [ "$2" = "fullscreen" ]; then
                xdo hide -a $STATUSBAR
                bspc config top_padding 0
            fi
        fi
        xdo id -rd | head -1 | xargs xdo activate
        # bspc node -f prev.local
        bspc node -n biggest.local
        ;;

    --close)
        xdo close
        if [ -s "$MODE" ]; then
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
