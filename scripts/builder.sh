cd $src
PATH="$busybox/bin"

# Copy scripts to bin
install -Dm755 bspwm/* -t $out/bspwm
install -Dm755 misc/* -t $out/misc
install -Dm755 xsel/* -t $out/xsel
install -Dm755 xprompt/* -t $out/xprompt

sed -i "s/@keyboards@/$keyboards/g" $out/xprompt/keyboards
