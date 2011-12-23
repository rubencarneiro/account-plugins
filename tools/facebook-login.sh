#! /bin/bash

./account-console signon_login "$1" oauth2 user_agent \
	-p Host=www.facebook.com \
	-p AuthPath=/dialog/oauth \
	-p RedirectUri=https://www.facebook.com/connect/login_success.html \
	-p ClientId=213156715390803

