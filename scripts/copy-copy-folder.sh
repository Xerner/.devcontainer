COPY_FOLDER_SOURCE=.devcontainer/copy
COPY_FOLDER_DESTINATION=.devcontainer/home
cp -rf $COPY_FOLDER_SOURCE/. $COPY_FOLDER_DESTINATION
echo -e "${COLOR_LIGHT_GREEN}copied contents of ${COLOR_LIGHT_PURPLE}$COPY_FOLDER_SOURCE${COLOR_LIGHT_GREEN} to ${COLOR_LIGHT_PURPLE}$COPY_FOLDER_DESTINATION${COLOR_NC}"
