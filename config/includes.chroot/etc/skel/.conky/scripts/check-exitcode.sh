#!/bin/bash
set -e
source ~/.conky/scripts.conf
for script in $EXITCHECK_SCRIPTS_PATH; do
	$script && echo -e "\${color 00DD00}■\${color} $(basename $script)" || echo "\${color FF0000}■\${color} $(basename $script)" 
done