import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        authenticationParameters: {
            "AuthPath": "o/oauth2/auth?access_type=offline&approval_prompt=force"
        }

        userAgent: "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

        function getUserName(reply, callback) {
            console.log("Access token: " + reply.AccessToken)
            var http = new XMLHttpRequest()
            var url = "https://www.googleapis.com/oauth2/v3/userinfo?alt=json";
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

            http.send("");
            return true
        }
    }
}
