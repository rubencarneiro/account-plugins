import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        function completeCreation(reply) {
            console.log("Access token: " + reply.AccessToken)
            var http = new XMLHttpRequest()
            var url = "https://api.vk.com/method/users.get?access_token=" + reply.AccessToken + "&fields=nickname,first_name,last_name";
            http.open("GET", url, true);
            http.onreadystatechange = function() {
                if (http.readyState === 4){
                    if (http.status == 200) {
                        console.log("ok")
                        console.log("response text: " + http.responseText)
                        var response = JSON.parse(http.responseText)
                        if (response.response && response.response.length > 0) {
                            var data = response.response[0]
                            var name = data.first_name + " " + data.last_name
                            if (data.nickname) {
                                name += " (" + data.nickname + ")"
                            }
                            account.updateDisplayName(name)
                        }
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
