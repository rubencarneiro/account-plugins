import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        property var __meData

        function getUserName(reply, callback) {
            console.log("Access token: " + reply.AccessToken)
            var http = new XMLHttpRequest()
            var url = "https://graph.facebook.com/me?access_token=" + reply.AccessToken;
            http.open("GET", url, true);
            http.onreadystatechange = function() {
                if (http.readyState === 4){
                    if (http.status == 200) {
                        console.log("ok")
                        console.log("response text: " + http.responseText)
                        __meData = JSON.parse(http.responseText)
                        callback(__meData.name)
                        return true
                    } else {
                        console.log("error: " + http.status)
                        return false
                    }
                }
            };

            http.send(null);
        }

        function beforeSaving(reply) {
            globalAccountService.updateSettings({
                'id': __meData.id
            })
            saveAccount()
        }
    }
}
