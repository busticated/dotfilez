#!/bin/bash
set -e

# make sure we're in a repo
repoRoot=$(hg root)
if [ -z $repoRoot ]
then
	exit
fi

constantsFile=$repoRoot/wp-shared/constants.inc.php
styleFile=$repoRoot/style.css

buildTimestamp(){
	year=$(date +%Y)
	month=$(date +%m)
	day=$(date +%d)

	echo "$year.$month.$day"
}

getLastPublished(){
	regx="define\( \'THEME_VERSION\', \'(.+)\' \)"

	while read LINE
	do
		[[ $LINE =~ $regx ]]
		if [ ! -z "${BASH_REMATCH[1]}" ]
		then
			pubDate="${BASH_REMATCH[1]}"
		fi
	done < $constantsFile
	echo $pubDate
}

setReleaseTag(){
	origDate=$(getLastPublished | sed -e 's/\([0-9]*.[0-9]*.[0-9]*\).*/\1/')
	origVer=$(getLastPublished | sed -e 's/...........\(.*\)/\1/')
	newDate=$(buildTimestamp | sed -e 's/\([0-9]*.[0-9]*.[0-9]*\).*/\1/')

	if [ "$origDate" == "$newDate" ]
	then
		echo $newDate.$((origVer+1))
	else
		echo $newDate.1
	fi
}

abortMsgAni(){
	echo -ne '::...aborting release...  (°_°) ┳━┳\r'
	sleep 0.4
	echo -ne '::...aborting release...  (╯°□°)╯ ︵ ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (╯°□°)╯ ︵  ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (╯°□°)╯ ︵   ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (╯°□°)╯ ︵    ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (╯°□°)╯ ︵     ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (°_°)           ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (°_°)            ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (°_°)             ┻━┻ \r'
	sleep 0.1
	echo -ne '::...aborting release...  (°_°)              XXX\r'
	sleep 0.2
	echo -ne '::...aborting release...  (°_°)               xx\r'
	sleep 0.1
	echo -ne '::...aborting release...  (°_°)                _\r'
	sleep 0.1
	echo -ne '::...aborting release...  ╰ (°u°)╯              \r'
	sleep 0.7
	echo '::...release aborted...                               '
}

relTag=$(setReleaseTag)
hgTag='release_'$( echo $relTag | sed -e 's/\([0-9]\{4\}\).\([0-9]\{1,2\}\).\([0-9]\{1,2\}.[0-9]\{1,2\}\)/\1\2\3/')

echo "::enter your release details below::"
read msg
echo "::release tag preview: hg tag -m" \"$msg\" $hgTag
read -p "::is this good to go (y/n)? "
if [ "$REPLY" != "y" ]
then
	abortMsgAni
	exit
fi

# find and replace release tags
echo "::...updating theme version"
sed -i '' -e "s/\(VERSION....\)[0-9]\{4\}.[0-9]\{1,2\}.[0-9]\{1,2\}.[0-9]\{1,2\}/\1$relTag/" $constantsFile
sed -i '' -e "s/\(Version:.\)[0-9]\{4\}.[0-9]\{1,2\}.[0-9]\{1,2\}.[0-9]\{1,2\}/\1$relTag/" $styleFile

echo "::...committing changeset"
hg com -m "Update release version"

echo "::...tagging revision"
hg tag -m "${msg}" ${hgTag}

echo "::...pushing"
hg push
