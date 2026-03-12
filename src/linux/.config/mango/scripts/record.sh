#!/usr/bin/env sh

PIDFILE="/tmp/wf-recorder.pid"

if pgrep -x wf-recorder > /dev/null; then
    pkill -INT wf-recorder
    rm -f "$PIDFILE"
    LAST=$(cat /tmp/wf-recorder-last)

    notify-send "Screen Recorder" "Stopped! Transcoding..."

    TRANSCODED="${LAST%.mp4}-transcoded.mp4"
    ffmpeg -i "$LAST" -c:v libx265 -crf 28 -preset slow -c:a copy "$TRANSCODED" && \
      rm "$LAST" && \
      mv "$TRANSCODED" "$LAST"

    notify-send "Screen Recorder" "Recording saved — $(basename "$LAST")" \
        --action="open=Open in file manager" \
        --wait &
    NOTIFY_PID=$!
    wait $NOTIFY_PID

    # notify-send --wait exits with action name... but this varies by implementation
    dbus-send --session --dest=org.freedesktop.FileManager1 --type=method_call \
        /org/freedesktop/FileManager1 \
        org.freedesktop.FileManager1.ShowItems \
        array:string:"file://$LAST" string:"" 2>/dev/null \
    || xdg-open "$(dirname "$LAST")"
else
    REGION=$(slurp -o) || exit 1
    OUTPUT=~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4
    echo "$OUTPUT" > /tmp/wf-recorder-last
    wf-recorder -g "$REGION" -f "$OUTPUT" &
    notify-send "Screen Recorder" "Recording started"
fi
