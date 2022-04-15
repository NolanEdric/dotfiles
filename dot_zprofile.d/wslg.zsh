# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
# unset DISPLAY # have more beautiful border
# export LIBGL_ALWAYS_INDIRECT=1 # this is great for old opengl apps (<= opengl 1.4), but newer opengl will not work
