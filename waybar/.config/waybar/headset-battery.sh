#!/bin/bash

while true; do
  BATTERY_LEVEL=$(solaar show 2>/dev/null | \
      awk '/G733 Gaming Headset/{found=1} /Battery:/{if(found==1) {print; exit}}' | \
      grep -oE '[0-9]+%')

  echo "${BATTERY_LEVEL}"

  # 30 min wait
  sleep 1800

done

