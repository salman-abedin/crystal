#!/usr/bin/env sh

###############################################################################
#                             Config
###############################################################################

# Status Bar
[ "$STATUS_BAR" ] || export STATUS_BAR=polybar

# BSPWM Specific settings
top_padding=35
bspc config borderless_monocle true
bspc config gapless_monocle true

###############################################################################
#                             Script
###############################################################################

hidden_windows=/tmp/crystal_0$(wmctrl -d | grep "\*" | cut -d ' ' -f 1)
mode="$hidden_windows"_mode

hide_nodes() {
    xdo id -rd | tee "$hidden_windows"
    [ -s "$hidden_windows" ] && cat "$hidden_windows" | xargs xdo hide
}

unhide_nodes() {
    cat "$hidden_windows" | xargs xdo show
    : > "$hidden_windows"
}


case $1 in

    --navigate)
        # Regular navigations (Put your window managers navigations here)
        if [ "$2" = "next" ]; then
            bspc node -f next.local && exit 0
        else
            bspc node -f prev.local && exit 0
            # xdo id -rd | head -1 | xargs xdo activate && exit 0
        fi

        # Edge cases
        [ ! -f "$hidden_windows" ] && exit 1
        [ "$(wc -l < "$hidden_windows")" = 0 ] && exit 1

        # This is where the fun begins

        current_window=$(xdo id)
        xdo hide

        if [ "$2" = "next" ]; then
            tail -1 "$hidden_windows" | xargs xdo show
            sed -i '$d' "$hidden_windows"
            printf "%s\n%s" "$current_window" "$(cat "$hidden_windows")" > "$hidden_windows"
        else
            head -1 "$hidden_windows" | xargs xdo show
            sed -i '1d' "$hidden_windows"
            echo "$current_window" >> "$hidden_windows"
        fi
        ;;

    --toggle)
        if [ -s "$mode" ]; then
            : > "$mode"
            unhide_nodes
            bspc desktop -l tiled
            if [ "$2" = "fullscreen" ]; then
                xdo show -a $STATUS_BAR
                bspc config top_padding $top_padding
            fi
        else
            echo mono > "$mode"
            hide_nodes
            bspc desktop -l monocle
            if [ "$2" = "fullscreen" ]; then
                xdo hide -a $STATUS_BAR
                bspc config top_padding 0
            fi
        fi
        bspc node -f prev.local
        bspc node -n biggest.local
        ;;

    --close)
        xdo close
        if [ -s "$hidden_windows" ]; then
            tail -1 "$hidden_windows" | xargs xdo show
            sed -i '$d' "$hidden_windows"
        fi
        ;;
    *) : ;;

esac
