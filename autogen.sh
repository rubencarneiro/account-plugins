echo "=== autogen.sh ==="
echo "current dir:"
ls -la
mkdir m4
echo "new dir:"
ls -la
autoreconf -i && intltoolize --copy --force --automake && ./configure "$@"
