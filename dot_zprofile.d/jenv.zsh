load_jenv() {
    unset -f java
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
}

java() {
    load_jenv
    java $@
}
