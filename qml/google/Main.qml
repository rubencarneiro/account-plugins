import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        authenticationParameters: {
            "AuthPath": "o/oauth2/auth?access_type=offline&approval_prompt=force"
        }

        function getUserName(reply, callback) {
            console.log("Access token: " + reply.AccessToken)
            var http = new XMLHttpRequest()
            var url = "https://www.googleapis.com/oauth2/v3/userinfo";
            http.open("POST", url, true);
            http.setRequestHeader("Authorization", "Bearer " + reply.AccessToken)
            http.onreadystatechange = function() {
                if (http.readyState === 4){
                    if (http.status == 200) {
                        console.log("ok")
                        console.log("response text: " + http.responseText)
                        var response = JSON.parse(http.responseText)
                        callback(response.email)
                    } else {
                        callback("", http.responseText)
                    }
                }
            };

            http.send(null);
            return true
        }
    }
}
