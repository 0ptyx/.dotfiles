
# Needed for PRIME
xrandr --setprovideroutputsource modesetting NVIDIA-0
# TODO:  What should I do with these?
dunst &
picom &
slstatus &
pipewire &
feh --bg-fill ~/.local/share/wallpapers/wallpaper
xrdb -merge ~/.Xresources
disp-layout
exec dbus-launch --sh-syntax --exit-with-session dwm
