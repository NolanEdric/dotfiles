# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     # echo "Reverting to nvm default version"
#     nvm use stable >/dev/null
#   fi
# }

# load_nvm() {
#   # unset -f node
  
#   [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
#   load-nvmrc
#   autoload -U add-zsh-hook
# }

# node() {
#   load_nvm
#   node $@
# }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# This lazy loads nvm
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  nvm $@
}

# This resolves the default node version
DEFAULT_NODE_VER="$( (< "$NVM_DIR/alias/default" || < ~/.nvmrc) 2> /dev/null)"
while [ -s "$NVM_DIR/alias/$DEFAULT_NODE_VER" ] && [ ! -z "$DEFAULT_NODE_VER" ]; do
  DEFAULT_NODE_VER="$(<"$NVM_DIR/alias/$DEFAULT_NODE_VER")"
done

# This adds the default node version to PATH
if [ ! -z "$DEFAULT_NODE_VER" ]; then
  export PATH="$HOME/.yarn/bin:$PATH:$NVM_DIR/versions/node/v${DEFAULT_NODE_VER#v}/bin"
fi
