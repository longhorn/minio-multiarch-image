#!/bin/bash

#set -x

ARCH=${1}

GITHUB_API_BASEURL="https://api.github.com"
GITHUB_REPOS_API_URL="${GITHUB_API_BASEURL}/repos"

GITHUB_REPO="minio/minio"
DOCKERHUB_REPO="minio/minio"

LATEST_TAG=`curl -s -L -H "Accept: application/vnd.github.v3+json" \
	"${GITHUB_REPOS_API_URL}/${GITHUB_REPO}/releases/latest" | jq -r '.tag_name'`

if [[ ${ARCH} == "" ]]; then
	echo "Missing ARCH argument"
else 
	echo "${LATEST_TAG}-${ARCH}" > .tags
fi

