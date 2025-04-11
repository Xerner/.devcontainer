source ~/bash/colors.sh
source ~/bash/.bash_git
source ~/bash/bash_prompt.sh
# source ~/bash/git-set-submodule-settings.sh

git config --global --add safe.directory "*"
git config --global core.editor "code --wait"

PATH="${HOME}/.bin:${PATH}"

if [[ -e ~/.ssh/config ]]; then
  SSH_CONFIG=$(cat ~/.ssh/config)
else 
  SSH_CONFIG="Does not exist"
fi
find ~/.ssh -maxdepth 1 -type f -exec chmod 600 {} \;

DOCKER_MOUNTS=$(mount | grep ^/dev/ | grep -v /etc | awk '{print $3}')

WELCOME_INFO="
██     ██ ███████ ██       ██████  ██████  ███    ███ ███████
██     ██ ██      ██      ██      ██    ██ ████  ████ ██     
██  █  ██ █████   ██      ██      ██    ██ ██ ████ ██ █████  
██ ███ ██ ██      ██      ██      ██    ██ ██  ██  ██ ██     
 ███ ███  ███████ ███████  ██████  ██████  ██      ██ ███████

Workspace Folder: ${WORKSPACE_FOLDER}

Docker Mounts
-------------------------------------------------
${DOCKER_MOUNTS}
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
