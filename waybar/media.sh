#!/usr/bin/env bash

usage() {
  echo "Usage: $0 [status|playpause|play|pause|next|previous]"
  exit 1
}

if [[ $# -ne 1 ]]; then
  usage
fi

ACTION="$1"

PLAYERS="$(playerctl -l 2>/dev/null)"
if [[ -z "$PLAYERS" ]]; then
  if [[ "$ACTION" == "status" ]]; then
    echo '{"tooltip":null,"text":null,"class":["stopped"]}'
    exit 0
  fi
fi

for P in $PLAYERS; do
    if [[ "$(playerctl -p "$P" status 2>/dev/null)" == "Playing" ]]; then
        PLAYER="$P"; break
    fi
done
: ${PLAYER:=$(echo "$PLAYERS" | grep -v '^firefox' | head -n1)}

case "$ACTION" in
  icon-prev|icon-next)
    if [[ -z "$PLAYERS" ]]; then
      echo '{"text":null}'
    else
      if [[ "$ACTION" == "icon-prev" ]]; then
        echo '{"text":" 󰒮 "}'
      else
        echo '{"text":" 󰒭 "}'
      fi
    fi
    ;;
  status)
    STATUS="$(playerctl -p "$PLAYER" status 2>/dev/null)"
    [[ -z "$STATUS" ]] && STATUS="Stopped"

    TITLE="$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null)"
    ARTIST="$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null)"
    ALBUM="$(playerctl -p "$PLAYER" metadata xesam:album 2>/dev/null)"

    LOWER_STATUS="$(echo "$STATUS" | tr '[:upper:]' '[:lower:]')"

    if [[ -z "$TITLE" && -z "$ARTIST" ]]; then
      TOOLTIP="null"
      TEXT="null"
      CLASS='["stopped"]'
    else
      TOOLTIP_STRING="$STATUS"
      [[ -n "$TITLE" ]] && TOOLTIP_STRING="$TOOLTIP_STRING: $TITLE"
      [[ -n "$ARTIST" ]] && TOOLTIP_STRING="$TOOLTIP_STRING - $ARTIST"
      [[ -n "$ALBUM" ]] && TOOLTIP_STRING="$TOOLTIP_STRING\n$ALBUM"
      TOOLTIP_STRING="$TOOLTIP_STRING \n\n($PLAYER)"

      TOOLTIP=$(echo "\"$TOOLTIP_STRING\"")

      if [[ -n "$TITLE" && -n "$ARTIST" ]]; then
        TEXT_STRING="$TITLE - $ARTIST"
      else
        TEXT_STRING="${TITLE}${ARTIST}"
      fi
      MAX_LEN=50
      if [ ${#TEXT_STRING} -gt $MAX_LEN ]; then
        SHORTENED="${TEXT_STRING:0:${MAX_LEN}}..."
      else
        SHORTENED="$TEXT_STRING"
      fi
      TEXT=$(echo "\"$SHORTENED\"")

      case "$LOWER_STATUS" in
        playing|paused) CLASS="[\"$LOWER_STATUS\"]" ;;
        *) CLASS='["stopped"]' ;;
      esac
    fi

    echo "{\"tooltip\":$TOOLTIP,\"text\":$TEXT,\"class\":$CLASS}"
    ;;

  playpause)
    playerctl -p "$PLAYER" play-pause
    ;;

  play)
    playerctl -p "$PLAYER" play
    ;;

  pause)
    playerctl -p "$PLAYER" pause
    ;;

  next)
    playerctl -p "$PLAYER" next
    ;;

  previous)
    playerctl -p "$PLAYER" previous
    ;;

  *)
    usage
    ;;
esac

