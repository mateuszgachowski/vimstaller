# Directories
VIM_DIR=~/.vim
HOME_DIR=~

# Sources
PLUGINS_URL="https://gist.github.com/mateuszgachowski-snippets/8046111/raw/vimplugins.txt"
PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
VIMRC_URL="https://gist.github.com/mateuszgachowski-snippets/8045995/raw/.vimrc"

# Colors
COLOR_YELLOW='\033[33;33m'
COLOR_GREEN='\033[33;32m'
COLOR_WHITE='\033[0;37m'
COLOR_CYAN='\033[33;36m'

# Check if the main VIM directory exists
if [[ ! -d "${VIM_DIR}" ]]; then
  echo "Creating ${VIM_DIR} directory..."
  mkdir "${VIM_DIR}"
else
  echo "${VIM_DIR} directory already exists..."
fi

# Create, if not yet created, necessary directories
if [[ ! -d "${VIM_DIR}/bundle" && ! -d "${VIM_DIR}/autoload" ]]; then
  echo "Creating structure for pathogen:"
fi

if [[ ! -d "${VIM_DIR}/bundle" ]]; then
  echo " bundle/"
  mkdir "${VIM_DIR}/bundle"
fi

if [[ ! -d "${VIM_DIR}/autoload" ]];then
  echo " autoload/"
  mkdir "${VIM_DIR}/autoload"
fi

# Download or skip installing pathogen.vim
echo -ne "\n${COLOR_YELLOW}[wait] ${COLOR_WHITE}Installing pathogen..."\\r
if [[ -e "${VIM_DIR}/autoload/pathogen.vim" ]]; then
  echo -e "${COLOR_YELLOW}[skip] ${COLOR_WHITE}"
else
  curl -s "$PATHOGEN_URL" > "${VIM_DIR}/autoload/pathogen.vim"
  echo -e "${COLOR_GREEN}[done] ${COLOR_WHITE}"
fi

# Pathogen plugins
echo -e "\nInstalling pathogen plugins..."
echo "-------------------------------------------"

echo -n "Do you want to install all plugins? (y/n): "
read ALL_PLUGINS

if [[ "$ALL_PLUGINS" == 'y' ]]; then
  ALL_PLUGINS=true
else
  ALL_PLUGINS=false
fi

get_plugin() {
  local plugin="$1"
  local repo="$2"
  echo -ne "${COLOR_YELLOW}[wait] ${COLOR_WHITE}Installing $plugin... "\\r
  git clone -q "$repo" "${VIM_DIR}/bundle/$1"
  echo -e "${COLOR_GREEN}[done]${COLOR_WHITE}"
}

# Get plugins from external source
exec 3< <(curl -s "$PLUGINS_URL")
while read -u 3 LINE;
do
  PLUGIN=$(echo $LINE | cut -d \| -f 1);
  REPO=$(echo $LINE | cut -d \| -f 2);
  if [[ -d "${VIM_DIR}/bundle/$PLUGIN" ]]; then
    echo -e "${COLOR_CYAN}[skip] ${COLOR_WHITE}\"$PLUGIN\": already installed."
  else
    if $ALL_PLUGINS ; then
      get_plugin $PLUGIN $REPO
    else 
      echo -n "Are you sure you want to install \"$PLUGIN\" (y/n): "
      read answer
      if [[ "$answer" == "y" ]]; then
        get_plugin $PLUGIN $REPO
      else
        echo -e "${COLOR_CYAN}[skip] ${COLOR_WHITE}\"$PLUGIN\""
      fi
    fi
  fi
done
echo "-------------------------------------------"
echo -e "Plugins are ready.\n"

# Save the .vimrc config

save_vimrc() {
  echo -ne "${COLOR_YELLOW}[wait] ${COLOR_WHITE}Saving .vimrc file..."\\r
  curl -s "${VIMRC_URL}" > "${HOME_DIR}/.vimrc"
  echo -e "${COLOR_GREEN}[done] ${COLOR_WHITE}"
}

if [[ -e "${HOME_DIR}/.vimrc" ]]; then
  echo -e "${COLOR_YELLOW}[warn] ${COLOR_WHITE}.vimrc file already exists"
  echo -n "Do you want to override your .vimrc file? (yes/no): "
  read override
  if [[ "$override" == "yes" ]]; then
    save_vimrc
  else
    echo -e "${COLOR_YELLOW}[skip] ${COLOR_WHITE}Leave users .vimrc file"
  fi
else
  save_vimrc
fi
echo "-------------------------------------------"
echo -e "\n${COLOR_GREEN}[done] ${COLOR_WHITE}VIM configuration successful\n"
exit 0

