query="$1"

appdirs=$(echo "${XDG_DATA_DIRS:-/usr/local/share:/usr/share}" \
  | tr ':' '\n' \
  | sed 's|$|/applications|')

for d in $appdirs; do
  for file in "$d"/*.desktop; do
    [ -f "$file" ] || continue
    filename=$(grep -m1 '^Name=' "$file" | cut -d= -f2-)
    if [ -z "$query" ] || echo "$filename" | grep -iq "$query"; then
      echo "$filename|||$file"
    fi
  done
done
