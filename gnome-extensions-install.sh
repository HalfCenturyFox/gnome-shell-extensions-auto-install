#!/bin/bash

array=( dash-to-dock@micxgx.gmail.com caffeine@patapon.info user-theme@gnome-shell-extensions.gcampax.github.com IP-Finder@linxgem33.com no-overview@fthx)

for i in "${array[@]}"
do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm *.zip
done
