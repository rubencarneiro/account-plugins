import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.OnlineAccounts 0.1

Column {
    id: root

    property variant __account: account

    signal finished

    anchors.margins: units.gu(1)
    spacing: units.gu(1)

    Label {
        anchors { left: parent.left; right: parent.right }
        text: i18n.dtr("account-plugins", "URL:")
    }

    TextField {
        id: urlField
        anchors { left: parent.left; right: parent.right }
        placeholderText: i18n.dtr("account-plugins", "http://example.org")
        focus: true

        inputMethodHints: Qt.ImhUrlCharactersOnly
    }

    Label {
        anchors { left: parent.left; right: parent.right }
        text: i18n.dtr("account-plugins", "Username:")
    }

    TextField {
        id: usernameField
        anchors { left: parent.left; right: parent.right }
        placeholderText: i18n.dtr("account-plugins", "Your username")

        KeyNavigation.tab: passwordField
    }

    Label {
        anchors { left: parent.left; right: parent.right }
        text: i18n.dtr("account-plugins", "Password:")
    }

    TextField {
        id: passwordField
        anchors { left: parent.left; right: parent.right }
        placeholderText: i18n.tr("Your password")
        echoMode: TextInput.Password

        inputMethodHints: Qt.ImhSensitiveData
    }

    Row {
        id: buttons
        anchors { left: parent.left; right: parent.right }
        height: units.gu(5)
        spacing: units.gu(1)
        Button {
            id: btnCancel
            text: i18n.tr("Cancel")
            color: "#1c091a"
            height: parent.height
            width: (parent.width / 2) - 0.5 * parent.spacing
            onClicked: finished()
        }
        Button {
            id: btnContinue
            text: i18n.tr("Continue")
            color: "#cc3300"
            height: parent.height
            width: (parent.width / 2) - 0.5 * parent.spacing
            onClicked: {
                account.updateDisplayName(usernameField.text + '@' + urlField.text)

                creds.userName = usernameField.text
                creds.secret = passwordField.text
                creds.sync()
            }
        }
    }

    Credentials {
        id: creds
        caption: account.provider.id
        acl: [ "unconfined" ]
        storeSecret: true
        onCredentialsIdChanged: root.credentialsStored()
    }

    AccountService {
        id: globalAccountSettings
        objectHandle: account.accountServiceHandle
        autoSync: false
    }

    function credentialsStored() {
        console.log("Credentials stored, id: " + creds.credentialsId)
        if (creds.credentialsId == 0) return

        globalAccountSettings.updateServiceEnabled(true)
        globalAccountSettings.credentials = creds
        globalAccountSettings.updateSettings({
            "host": checkURL(urlField.text)
        })
        account.synced.connect(finished)
        account.sync()
    }

    // check host url for http
    function checkURL(url) {
        // if the URL doesn't contain HTTP(S) then add it!
        if (url.indexOf('http') >= 0) {
            return urlField.text
        } else {
            console.debug("added http")
            return 'http://' + urlField.text
        }
    }

}
