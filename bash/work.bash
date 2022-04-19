#!/usr/bin/env bash

export GITLAB_TOKEN="glpat-H3t8SVx8AjAy2urBkzCd"
source /mnt/departments/engineering/modules/latest/init/bash
module load verible

# source ~/tools/Xilinx/Vivado/2021.2/settings64.sh
# source ~/tools/Xilinx/PetaLinux/2021.2/settings.sh

export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH="$HOME/tools/nordic/gcc-arm-none-eabi-9-2019-q4-major"
export PATH="$PATH:$GNUARMEMB_TOOLCHAIN_PATH/bin"
export PATH=$HOME/tools/gn:"$PATH"
# export PATH=$HOME/tools/nordic/arm_segger_embedded_studio_v568_linux_x64_nordic/bin:"$PATH"
