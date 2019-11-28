#!/bin/bash

set -euf -o pipefail
# Keep environment clean
export LC_ALL="C"
# Set variables
readonly TMP_DIR="/tmp"
readonly TMP_OUTPUT="${TMP_DIR}/$$.out"
readonly BASE_DIR="$(dirname "$(realpath "$0")")"
readonly MY_NAME="${0##*/}"
# Colours
readonly C_NOC="\\033[0m"    # No colour
readonly C_RED="\\033[0;31m" # Red
readonly C_GRN="\\033[0;32m" # Green
readonly C_BLU="\\033[0;34m" # Blue
readonly C_PUR="\\033[0;35m" # Purple
readonly C_CYA="\\033[0;36m" # Cyan
readonly C_WHI="\\033[0;37m" # White
### Helper functions
print_red () { local i; for i in "$@"; do echo -e "${C_RED}${i}${C_NOC}"; done }
print_grn () { local i; for i in "$@"; do echo -e "${C_GRN}${i}${C_NOC}"; done }
print_blu () { local i; for i in "$@"; do echo -e "${C_BLU}${i}${C_NOC}"; done }
print_pur () { local i; for i in "$@"; do echo -e "${C_PUR}${i}${C_NOC}"; done }
print_cya () { local i; for i in "$@"; do echo -e "${C_CYA}${i}${C_NOC}"; done }
print_whi () { local i; for i in "$@"; do echo -e "${C_WHI}${i}${C_NOC}"; done }

# Cleanup on exit
trap 'rm -rf ${TMP_OUTPUT}' \
  EXIT SIGHUP SIGINT SIGQUIT SIGPIPE SIGTERM

release=$(mazer build | tail -n1 | awk '{print $NF}')
mazer publish --api-key=${galaxy_api_key} ${release}
