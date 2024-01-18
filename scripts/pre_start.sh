#!/usr/bin/env bash

export PYTHONUNBUFFERED=1

echo "Template version: ${TEMPLATE_VERSION}"

if [[ -e "/workspace/template_version" ]]; then
    EXISTING_VERSION=$(cat /workspace/template_version)
else
    EXISTING_VERSION="0.0.0"
fi

sync_apps() {
    # Sync Kohya_ss to workspace to support Network volumes
    echo "Syncing Kohya_ss to workspace, please wait..."
    rsync --remove-source-files -rlptDu /kohya_ss/ /workspace/kohya_ss/
    rm -rf /kohya_ss

    echo "${TEMPLATE_VERSION}" > /workspace/template_version
}

fix_venvs() {
    # Fix the venv to make it work from /workspace
    echo "Fixing venv..."
    /fix_venv.sh /kohya_ss/venv /workspace/kohya_ss/venv
}

link_models() {
    # Link model
    ln -s /sd-models/sd_xl_base_1.0.safetensors /workspace/sd_xl_base_1.0.safetensors
}

if [ "$(printf '%s\n' "$EXISTING_VERSION" "$TEMPLATE_VERSION" | sort -V | head -n 1)" = "$EXISTING_VERSION" ]; then
    if [ "$EXISTING_VERSION" != "$TEMPLATE_VERSION" ]; then
        sync_apps
        fix_venvs
        link_models

        # Configure accelerate
        echo "Configuring accelerate..."
        mkdir -p /root/.cache/huggingface/accelerate
        mv /accelerate.yaml /root/.cache/huggingface/accelerate/default_config.yaml

        # Create logs directory
        mkdir -p /workspace/logs
    else
        echo "Existing version is the same as the template version, no syncing required."
    fi
fi

if [[ ${DISABLE_AUTOLAUNCH} ]]
then
    echo "Auto launching is disabled so the application will not be started automatically"
    echo "You can launch them it using the launcher script:"
    echo ""
    echo "   cd /workspace/kohya_ss"
    echo "   source /workspace/kohya_ss/venv/bin/activate"
    echo "   ./gui.sh --listen 0.0.0.0 --server_port 3001 --headless"
else
    echo "Starting Kohya_ss Web UI"
    cd /workspace/kohya_ss
    source venv/bin/activate
    nohup ./gui.sh --listen 0.0.0.0 --server_port 3001 --headless > /workspace/logs/kohya_ss.log 2>&1 &
    echo "Kohya_ss started"
    echo "Log file: /workspace/logs/kohya_ss.log"
fi

echo "All services have been started"
