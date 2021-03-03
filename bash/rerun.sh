#! /bin/bash
set -u

errors=0

function run_cmd(){
	"$@"
	[[ $? -ne 0 ]] && ((errors++))
}

# check args and prompt to proceed
if [ $# -lt 2 ]; then
	echo ":::: Error: Missing script arguments!"
	echo ":::: Fix: \`command\` is required - e.g. \`npm run my-script\`"
	echo ":::: Fix: \`iterations\` is required - e.g. \`3\`"
	echo ":::: Usage: rerun <script> <iterations>"
	exit 1
fi

script=$1
iterations=$2

for i in $(seq 1 $iterations);
	do
		run_cmd $script
		echo -e "\n\n- - - - - - - - - - - -"
		echo "ran: ${i} | errors: ${errors}"
done

