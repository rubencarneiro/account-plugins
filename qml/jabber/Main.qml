import Ubuntu.OnlineAccounts.Plugin 1.0

Column {
    id: root

    property string domain: "ubuntu-system-settings-online-accounts"

    anchors.left: parent.left
    anchors.right: parent.right

    TextField {
        id: userName
        placeholderText: i18n.dtr(domain, "User name")
        readOnly: account.accountId !== 0
    }

    TextField {
        id: password
        placeholderText: i18n.dtr(domain, "Password")
    }
}
