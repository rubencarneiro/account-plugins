#! /bin/bash

set -e

USERNAME="$1"

CREATION_PARAMS=('--print-id' \
	-s 'auth/oauth2/user_agent/Host=www.facebook.com' \
	-s 'auth/oauth2/user_agent/AuthPath=/dialog/oauth' \
	-s 'auth/oauth2/user_agent/ClientId=213156715390803' \
	-s 'auth/oauth2/user_agent/RedirectUri=https://www.facebook.com/connect/login_success.html' \
	-s 'auth/oauth2/user_agent/ResponseType/item0=token' \
	-s 'auth/oauth2/user_agent/Scope/item0=offline_access' \
	-s 'auth/oauth2/user_agent/Scope/item1=publish_stream' \
	-s 'auth/oauth2/user_agent/Scope/item2=user_photos' \
	-s 'auth/oauth2/user_agent/Scope/item3=user_videos' \
	-s 'auth/oauth2/user_agent/Display=popup' \
)

ID="$(./account-console create facebook ${CREATION_PARAMS[@]})"
./account-console edit "$ID" --username "$USERNAME"

#./account-console login "$1" oauth2 user_agent \
#	-p Host=www.facebook.com \
#	-p AuthPath=/dialog/oauth \
#	-p RedirectUri=https://www.facebook.com/connect/login_success.html \
#	-p ClientId=213156715390803

