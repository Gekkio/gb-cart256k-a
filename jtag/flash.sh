#!/bin/bash
set -euo pipefail

BASE_PATH=`dirname $0`
CFG_FILE=${BASE_PATH}/4032ze.cfg
SVF_FILE=${BASE_PATH}/../isplever/gb_cart2m_a_epv.svf

openocd -f "${CFG_FILE}" -c "init; svf ${SVF_FILE} quiet; jtag arp_init; exit"
