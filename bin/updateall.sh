#!/bin/bash

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
NO_C='\033[0m' # Other Constants
PKGLCK_GIT_OUT=' M package-lock.json'
PKGLCK_NAME='package-lock.json'

# Functions
log_action() {
	echo -e "${CYAN_C}> ${1}${NO_C}"
}
log_warn() {
	echo -e "${YELLOW_C}> WARN: $1${NO_C}"
}
log_error() {
	echo -e "${RED_C}> ERROR: $1${NO_C}"
}
log_success() {
	echo -e "${GREEN_C}$1${NO_C}"
}

if [[ -f "$1" ]]; then
	log_action "Converting file to repositories..."
	REPOS=(`cat $1`)
else
	REPOS=($@)
fi

log_success "Updating the following repositories:"
log_success "${REPOS[*]}"
DIR=`pwd` REPO_STATUS=("${REPOS[@]}")
REPO_COUNT=0
for REPO in ${REPOS[@]}; do
	STATUS="updating"
	echo -e "\n"
	log_action "== Updating ${REPO} =="
	cd ${DIR}/${REPO}
	GIT_LOG="git-pull.log"

	ISMASTER=`git branch | grep '*'`
	if [[ $(git branch | grep '*') != "* master" ]]; then
		log_error "Not in master!"
	  log_warn "SKIPPED."
		# Status
		STATUS="skipped not in master"
		REPO_STATUS[$REPO_COUNT]="${STATUS}"
		let REPO_COUNT+=1;
		continue
	fi

	FILES_CHANGED=$(git status -s)
  if [[ "${FILES_CHANGED}" == "${PKGLCK_GIT_OUT}" ]]; then
		log_warn "Clearing changes to package-lock.json"
		log_action "git checkout $PKGLCK_NAME${NO_C}"
		git checkout $PKGLCK_NAME
	fi

	echo -e "${CYAN_C}> git pull origin master${NO_C}"
	# Writes both stdout and stderr to $GIT_LOG as well as terminal output
	git pull origin master > >(tee -a $GIT_LOG) 2> >(tee -a $GIT_LOG)

	echo `grep -q "Aborting" $GIT_LOG`

	STATUS="updated"
	if grep -q "Already up-to-date" $GIT_LOG; then
		log_success "== Up-to-date, skipping rest of instructions..."
		STATUS="already up-to-date"
	elif grep -q "Aborting" $GIT_LOG; then
		log_error "Aborted git command for ${REPO}..."
		STATUS="error updating"
	elif grep -q "error" $GIT_LOG; then
		log_error "Error found in git command for ${REPO}..."
		STATUS="error updating"
#	else	
#		log_action "git push origin master"
#		git push origin master
#
#		log_action "npm i -q"
#		npm i -q
	else
		log_success "== UPDATE [${REPO}] COMPLETE"
	fi


	# Cleanup
	rm $GIT_LOG

	# Status
	REPO_STATUS[$REPO_COUNT]="${STATUS}"
	let REPO_COUNT+=1;
done

echo -e "\nRepository update summary:"
for (( i=0; i<${#REPOS[@]}; i++)); do
	printf "%25s %25s\n" "${REPOS[$i]}" "${REPO_STATUS[$i]}"
done

