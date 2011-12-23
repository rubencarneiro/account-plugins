#! /bin/bash

set -e

USERNAME="$1"

CREATION_PARAMS=('--print-id' \
	-s 'auth/oauth2/Host=www.facebook.com' \
	-s 'auth/oauth2/AuthPath=/dialog/oauth' \
	-s 'auth/oauth2/ClientId=213156715390803' \
	-s 'auth/oauth2/RedirectUri=https://www.facebook.com/connect/login_success.html' \
	-s 'auth/oauth2/ResponseType/item0=token' \
	-s 'auth/oauth2/Scope/item0=offline_access' \
	-s 'auth/oauth2/Scope/item1=publish_stream' \
	-s 'auth/oauth2/Scope/item2=user_photos' \
	-s 'auth/oauth2/Scope/item3=user_videos' \
)

ID="$(./account-console create facebook ${CREATION_PARAMS[@]})"
./account-console edit "$ID" --username "$USERNAME"

#./account-console login "$1" oauth2 user_agent \
#	-p Host=www.facebook.com \
#	-p AuthPath=/dialog/oauth \
#	-p RedirectUri=https://www.facebook.com/connect/login_success.html \
#	-p ClientId=213156715390803

