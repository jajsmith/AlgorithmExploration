#!/bin/sh

# Update All
# by Jonathan Smith
#
# Input: List of repositories which are subdirectories in the current directory
# eg. './updateall.sh repo1 repo2 repo3'
#
# Expects all git repos to be forked (ie. upstream points to original, 
#   origin points to fork)

# Colours
RED_C='\033[0;31m'
GREEN_C='\033[0;32m'
CYAN_C='\033[0;36m'
YELLOW_C='\033[0;33m'
NO_C='\033[0m'

# Other Constants
PKGLCK_GIT_OUT=' M package-lock.json'
PKGLCK_NAME='package-lock.json'

# Functions
log_action() {
	echo "${CYAN_C}> ${1}${NO_C}"
}
log_warn() {
	echo "${YELLOW_C}> WARN: $1${NO_C}"
}
log_error() {
	echo "${RED_C}> ERROR: $1${NO_C}"
}
log_success() {
	echo "${GREEN_C}$1${NO_C}"
}

DIR=`pwd`
REPOS=($@)
echo "Updating the following repositories:"
echo ${REPOS[*]}

for REPO in ${REPOS[@]}; do
	echo "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	log_action "== Updating ${REPO} =="
	cd ${DIR}/${REPO}
	GIT_LOG="git-pull.log"

	ISMASTER=`git branch | grep '*'`
	if [[ $(git branch | grep '*') != "* master" ]]; then
		log_error "Not in master!"
	  log_warn "SKIPPED."
		continue
	fi

	FILES_CHANGED=$(git status -s)
  if [[ "${FILES_CHANGED}" == "${PKGLCK_GIT_OUT}" ]]; then
		log_warn "Clearing changes to package-lock.json"
		log_action "git checkout $PKGLCK_NAME${NO_C}"
		git checkout $PKGLCK_NAME
	fi

	echo "${CYAN_C}> git pull upstream master${NO_C}"
	git pull upstream master | tee $GIT_LOG

	if grep -q "Already up-to-date" $GIT_LOG; then
		log_success "Up-to-date, skipping rest of instructions..."
	else	
		log_action "git push origin master"
		git push origin master

		log_action "npm i -q"
		npm i -q
	fi

	log_success "== UPDATE [${REPO}] COMPLETE =="

	# Cleanup
	rm $GIT_LOG
done


