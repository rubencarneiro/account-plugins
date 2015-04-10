import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        function completeCreation(reply) {
            console.log("Access token: " + reply.AccessToken)
            var http = new XMLHttpRequest()
            var url = "https://graph.facebook.com/me?access_token=" + reply.AccessToken;
            http.open("GET", url, true);
            http.onreadystatechange = function() {
                if (http.readyState === 4){
                    if (http.status == 200) {
                        console.log("ok")
                        console.log("response text: " + http.responseText)
                        var response = JSON.parse(http.responseText)
                        account.updateDisplayName(response.name)
                        globalAccountService.updateSettings({
                            'id': response.id
                        })
                        account.synced.connect(finished)
                        account.sync()

                    } else {
                        console.log("error: " + http.status)
                        cancel()
                    }
                }
            };

            http.send(null);
        }
    }
}
