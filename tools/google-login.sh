#! /bin/bash

./account-console signon_login "$1" oauth2 user_agent \
	-p Host=accounts.google.com \
	-p AuthPath=o/oauth2/auth \
	-p RedirectUri=http://www.mardy.it/oauth2callback \
	-p ClientId=1041829795610-htf69c529db58qcq8jvf58bijn1ie3oi.apps.googleusercontent.com \
	-p ResponseType=token \
	-p Scope=lh2

