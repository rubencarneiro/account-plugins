import Ubuntu.OnlineAccounts.Setup 1.0

OAuthMain {
    creationComponent: OAuth {
        function getUserName(reply) {
            return reply.username
        }
    }
}
