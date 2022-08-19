#!/bin/bash

host_hook_md5=$(md5sum /host/usr/bin/nvidia-container-runtime-hook | awk '{print $1}')
desired_hook_md5=$(md5sum /usr/bin/egpu-nvidia-container-runtime-hook | awk '{print $1}')

host_toolkit_md5=$(md5sum /host/usr/bin/nvidia-container-toolkit | awk '{print $1}')
desired_toolkit_md5=$(md5sum /usr/bin/egpu-nvidia-container-toolkit | awk '{print $1}')

if [[ ${host_hook_md5} !=  ${desired_hook_md5} ]]; then
	mv /host/usr/bin/nvidia-container-runtime-hook /host/usr/bin/nvidia-container-runtime-hook-bak
	cp --preserve=timestamps /usr/bin/egpu-nvidia-container-runtime-hook /host/usr/bin/nvidia-container-runtime-hook
fi

if [[ ${host_toolkit_md5} !=  ${desired_toolkit_md5} ]]; then
	mv /host/usr/bin/nvidia-container-toolkit /host/usr/bin/nvidia-container-toolkit-bak
	cp --preserve=timestamps /usr/bin/egpu-nvidia-container-toolkit /host/usr/bin/nvidia-container-toolkit
fi
