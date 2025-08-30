if [ $# -eq 0 ]; then
  echo "Usage: $0 <pattern1> [pattern2] ..."
  exit 1
fi

all_bins=$(IFS=':'
for p in $PATH; do
  find -L "$p" -type f -executable -print 2>/dev/null
done
)

matches=$all_bins
for pattern in "$@"; do
  matches=$(echo "$matches" | grep -i "$pattern")
done

if [ -n "$matches" ]; then
  echo "$matches"
else
  echo "Nothing found: $*"
fi
