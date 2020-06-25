#!/usr/bin/env sh

###############################################################################
#                             Config
###############################################################################

# BSPWM Specific settings
top_padding=35
bspc config borderless_monocle true
bspc config gapless_monocle true

###############################################################################
#                             Script
###############################################################################

WORKSPACE=/tmp/crystal_ws$(xdotool get_desktop)

solo() {
    case $1 in
        on)
            echo solo >> "$WORKSPACE"
            xdo id -rd && xdo id -rd | xargs xdo hide
            bspc desktop -l monocle
            ;;
        off)
            sed -i '/solo/d' "$WORKSPACE"
            xdo id -rd && xdo id -rd | xargs xdo show
            bspc desktop -l tiled
            ;;
    esac
    xdo id -rd | head -1 | xargs xdo activate
    bspc node -n biggest.local
}

case $1 in
    --navigate)
        shift
        window=$(xdo id -rd | head -1)
        case $1 in
            next)
                xdotool search --desktop "$(xdotool get_desktop)" . windowactivate && exit
                # window=$(xdo id -rd | tail -1)
                ! grep next "$WORKSPACE" && echo next >> "$WORKSPACE" && window=$(xdo id -rd | tail -1)
                ;;
            prev)
                # window=$(xdo id -rd | head -1)
                grep next "$WORKSPACE" && sed -i 's/next//' "$WORKSPACE" && window=$(xdo id -rd | tail -1)
                ;;
        esac
        if grep solo "$WORKSPACE" && xdo id -rd; then
            # xdo hide
            xdo show "$window"
            xdo id -rd | tail -1 | xargs xdo hide
        else
            xdo activate "$window"
            # xdotool windowactivate "$window"
        fi
        ;;
    --toggle)
        shift
        case $1 in
            solo)
                if grep solo "$WORKSPACE"; then
                    solo off
                else
                    solo on
                fi
                ;;
            fullscreen)
                if grep fullscreen "$WORKSPACE"; then
                    sed -i '/fullscreen/d' "$WORKSPACE"
                    xdo show -a "$STATUSBAR"
                    solo off
                    bspc config top_padding $top_padding
                else
                    echo fullscreen >> "$WORKSPACE"
                    xdo hide -a "$STATUSBAR"
                    solo on
                    bspc config top_padding 0
                fi
                ;;
        esac
        ;;
    --close)
        xdo close
        if grep solo "$WORKSPACE"; then
            if xdo id -rd; then
                xdo id -rd | head -1 | xargs xdo show
            else
                xdo show -a "$STATUSBAR"
                bspc config top_padding $top_padding
            fi
        fi
        ;;
    *) : ;;
esac
