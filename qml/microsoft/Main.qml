import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        function getUserName(reply, callback) {
            var http = new XMLHttpRequest();
            var url = "https://graph.microsoft.com/v1.0/me";
            http.open("GET", url, true);
            http.setRequestHeader("Authorization", "bearer " + reply.AccessToken);
            http.onreadystatechange = function() {
                if (http.readyState === 4) {
                    if (http.status === 200) {
                        console.log("response text: " + http.responseText);
                        var response = JSON.parse(http.responseText);
                        callback(response.userPrincipalName ? response.userPrincipalName : response.displayName);
                    } else {
                        console.log("error: " + http.status);
                        console.log("response text: " + http.responseText);
                        cancel();
                    }
                }
            };
            http.send(null);
            return true;
        }
    }
}
