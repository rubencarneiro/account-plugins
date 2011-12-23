#! /bin/bash

set -e

USERNAME="$1"

CREATION_PARAMS=('--print-id' \
	-s 'auth/oauth2/Host=accounts.google.com' \
	-s 'auth/oauth2/AuthPath=o/oauth2/auth' \
	-s 'auth/oauth2/ClientId=1041829795610-htf69c529db58qcq8jvf58bijn1ie3oi.apps.googleusercontent.com' \
	-s 'auth/oauth2/RedirectUri=http://www.mardy.it/oauth2callback' \
	-s 'auth/oauth2/ResponseType/item0=token')

ID="$(./account-console create google ${CREATION_PARAMS[@]})"
./account-console edit "$ID" --username "$USERNAME"

