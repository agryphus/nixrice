#!/usr/bin/env sh
# Script for opening a file, intended for use by a terminal file manager.

# Whether to open in a new window
detatch=0
[ "$1" = "detatch" ] && detatch=1 && shift 1

# First arg must be a file
[ ! -f "$1" ] && echo "Not a file: '$1'" && exit 1

function launch_gui() {
    if [ "$detatch" -eq 0 ]; then
        [ -n "$WAYLAND_DISPLAY" ] \
            && precmd="swallow" `# For Hyprland` \
            || precmd="devour"   # For X
    else
        precmd="setsid -f"
    fi

    $precmd "$@" >/dev/null 2>&1
}

function launch_term() {
    if [ "$detatch" -eq 1 ]; then
        # This is a bit of a hack.  Shell only expects a single argument into
        # the -c flag, so it needs to be wrapped in quotes.  However, if "$@"
        # wher passed in with `mpv "my file.mp3"`, it would not preserve the
        # $2 having a space and would instead split it up into 3 arguments
        # into the new shell.  Wrapping everything argument in quotes is the
        # only general solution I could come up with.
        command_string=""
        while [ $# -gt 0 ]; do
            command_string="$command_string \"$1\""
            shift
        done
        setsid -f $TERMINAL -e $SHELL -c "$command_string; exec $SHELL" >/dev/null 2>&1
    else
        clear
        "$@"
    fi
}

case $(file --mime-type "$1" -b) in
    application/javascript|\
    application/json|\
	application/pgp-encrypted|\
    application/x-subrip|\
    inode/x-empty|\
    text/*)
        case "${1##*.}" in
            org|typ)
                # Any "document" like file ought to be in emacs
                launch_gui emacsclient -c "$1"
                exit
                ;;
        esac

        launch_term nvim "$1"
        ;;
    image/*)
        launch_gui nsxiv "$1"
        ;;
	video/*) 
        launch_gui mpv -quiet "$1"
        ;;
    application/epub*|\
    application/octet-stream|\
    application/pdf|\
    application/postscript|\
    application/vnd.djvu|\
    image/vnd.djvu)
        launch_gui zathura "$1"
        ;;
    audio/*|\
    video/x-ms-asf) 
        [ -z "$(mediainfo "$1" | grep "Cover\s*: Yes")" ] \
            && (launch_term mpv --audio-display=no "$1") \
            || (launch_gui mpv "$1")
        ;;
    application/msword|\
    application/octet-stream|\
    application/vnd.ms-powerpoint|\
    application/vnd.oasis.opendocument.database|\
    application/vnd.oasis.opendocument.formula|\
    application/vnd.oasis.opendocument.graphics|\
    application/vnd.oasis.opendocument.graphics-template|\
    application/vnd.oasis.opendocument.presentation|\
    application/vnd.oasis.opendocument.presentation-template|\
    application/vnd.oasis.opendocument.spreadsheet|\
    application/vnd.oasis.opendocument.spreadsheet-template|\
    application/vnd.oasis.opendocument.text|\
    application/vnd.openxmlformats-officedocument.presentationml.presentation|\
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet|\
    application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        launch_gui libreoffice "$1"
        ;;
    *)
        ;;
esac

exit 0

