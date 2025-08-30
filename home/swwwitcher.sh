current_img=$(swww query | grep -m1 -o 'image: .*' | awk '{print $2}')

if [[ "$current_img" == *"dark"* ]]; then
    swww img "$HOME/nixos-everforest-light.png"
elif [[ "$current_img" == *"light"* ]]; then
    swww img "$HOME/nixos-everforest-color.png"
elif [[ "$current_img" == *"color"* ]]; then
    swww img "$HOME/nixos-everforest-dark.png"
else
    echo "wallpaper not found: $current_img"
    exit 1
fi
