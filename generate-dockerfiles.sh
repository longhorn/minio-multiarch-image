#!/bin/bash

#set -x

GITHUB_API_BASEURL="https://api.github.com"
GITHUB_REPOS_API_URL="${GITHUB_API_BASEURL}/repos"

GITHUB_REPO="minio/minio"
DOCKERHUB_REPO="minio/minio"

LATEST_TAG=`curl -s -L -H "Accept: application/vnd.github.v3+json" \
	"${GITHUB_REPOS_API_URL}/${GITHUB_REPO}/releases/latest" | jq -r '.tag_name'`

	
echo "FROM ${DOCKERHUB_REPO}:${LATEST_TAG}" > Dockerfile.amd64

ARCH=("arm64" "arm" "ppc64le" "s390x")
for arch in ${ARCH[@]}; do
	echo "FROM ${DOCKERHUB_REPO}:${LATEST_TAG}-${arch}" > "Dockerfile.${arch}"
done
