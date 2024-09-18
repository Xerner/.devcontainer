source ~/colors.sh
source ~/.bash_git
source ~/bash_prompt.sh
source ~/add-git-info-from-env.sh
source ~/git-set-submodule-settings.sh

git config --global --add safe.directory "*"
git config --global core.editor "code --wait"

PATH="${HOME}/.bin:${PATH}"

if [[ -e ~/.ssh/config ]]; then
  SSH_CONFIG=$(cat ~/.ssh/config)
else 
  SSH_CONFIG="Does not exist"
fi
find ~/.ssh -maxdepth 1 -type f -exec chmod 600 "{}" \;

WELCOME_INFO="
██     ██ ███████ ██       ██████  ██████  ███    ███ ███████
██     ██ ██      ██      ██      ██    ██ ████  ████ ██     
██  █  ██ █████   ██      ██      ██    ██ ██ ████ ██ █████  
██ ███ ██ ██      ██      ██      ██    ██ ██  ██  ██ ██     
 ███ ███  ███████ ███████  ██████  ██████  ██      ██ ███████

Workspace Folder: ${WORKSPACE_FOLDER}
${COLOR_YELLOW}
Git
-------------------------------------------------
Username:    $GIT_USER
Email:       $GIT_EMAIL
${COLOR_LIGHT_CYAN}
SSH Config
-------------------------------------------------
$SSH_CONFIG

Checkout ~/.ssh for more
${COLOR_NC}
to see this info again, printf \"\$WELCOME_INFO\"
"

printf "$WELCOME_INFO"