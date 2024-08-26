eval $(gp env -e)
cd /workspace
if [ -v EDGE_CONFIGURATION_REPOSITORY_URL ]; then
    if [ -d microsoft-edge-config-private ]; then
        cd microsoft-edge-config-private &&
            git pull &&
            cd ..
    else
        git clone $(echo $EDGE_CONFIGURATION_REPOSITORY_URL) microsoft-edge-config-private
    fi
    rm -rf ~/.config/microsoft-edge-dev &&
    ln -s microsoft-edge-config-private/microsoft-edge-dev ~/.config/microsoft-edge-dev
fi
microsoft-edge-dev