import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        function getUserName(reply) {
            var http = new XMLHttpRequest();
            var url = "https://api.onedrive.com/v1.0/drive";
            http.open("GET", url, true);
            http.setRequestHeader("Authorization", "bearer " + reply.AccessToken);
            http.onreadystatechange = function() {
                if (http.readyState === 4) {
                    if (http.status === 200) {
                        var response = JSON.parse(http.responseText);
                        account.updateDisplayName(response.owner.user.displayName +
                                                  " ( id: " + response.owner.user.id + ")");
                        account.synced.connect(finished);
                        account.sync();
                    } else {
                        cancel();
                    }
                }
            };
            http.send(null);
        }
    } 
}
