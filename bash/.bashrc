# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias la='ls -a'
alias cls='clear'
# alias battery='solaar show | grep -E "Battery:" | tail -n 1 | awk "{print \$2 \" \" \$4}" | tr -d ","'
alias rgboff='openrgb --server --device "G733 Gaming Headset" --mode Off'
alias battery="solaar show 2>/dev/null | awk '/G733 Gaming Headset/{found=1} /Battery:/{if(found==1) {print; exit}}' | grep -oE '[0-9]+%'"
alias addpy='export PYTHONPATH="$PYTHONPATH:$(pwd)"'

# uv
export PATH="/home/jacob/.local/share/../bin:$PATH"
