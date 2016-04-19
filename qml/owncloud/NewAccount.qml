import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.OnlineAccounts 0.1

Column {
    id: root

    property variant __account: account

    signal finished

    anchors.margins: units.gu(1)
    spacing: units.gu(1)

    property string __host: ""
    property bool __busy: false

    Label {
        anchors { left: parent.left; right: parent.right }
        text: i18n.dtr("account-plugins", "URL:")
    }

    TextField {
        id: urlField
        anchors { left: parent.left; right: parent.right }
        placeholderText: i18n.dtr("account-plugins", "http://example.org")
        focus: true
        enabled: !__busy

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
        enabled: !__busy

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
        enabled: !__busy

        inputMethodHints: Qt.ImhSensitiveData
        Keys.onReturnPressed: login()
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
            onClicked: login()
            enabled: !__busy
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

    function login() {
        __host = checkURL(urlField.text)
        var username = usernameField.text
        var password = passwordField.text

        __busy = true
        checkAccount(__host, username, password, function(success) {
            console.log("callback called: " + success)
            if (success) {
                var strippedHost = __host.replace(/^https?:\/\//, '')
                account.updateDisplayName(username + '@' + strippedHost)
                creds.userName = username
                creds.secret = password
                creds.sync()
            }
            __busy = false
        })
    }

    function findChild(node, tagName) {
        if (!node) return node;
        var children = node.childNodes
        for (var i = 0; i < children.length; i++) {
            if (children[i].nodeName == tagName) {
                return children[i]
            }
        }
        return null
    }

    function checkAccount(host, username, password, callback) {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                console.log("response: " + request.responseText)
                if (request.status == 200) {
                    var root = request.responseXML.documentElement
                    var metaElement = findChild(root, "meta")
                    var statusElement = findChild(metaElement, "status")
                    if (statusElement && statusElement.childNodes.length > 0 &&
                        statusElement.childNodes[0].nodeValue == "ok") {
                        callback(true)
                    } else {
                        callback(false)
                    }
                } else {
                    callback(false)
                }
            }
        }
        request.open("POST", host + "/ocs/v1.php/person/check", true);
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var body = "login=" + username + "&password=" + password
        request.send(body);

    }

    function credentialsStored() {
        console.log("Credentials stored, id: " + creds.credentialsId)
        if (creds.credentialsId == 0) return

        globalAccountSettings.updateServiceEnabled(true)
        globalAccountSettings.credentials = creds
        globalAccountSettings.updateSettings({
            "host": __host
        })
        account.synced.connect(finished)
        account.sync()
    }

    // check host url for http
    function checkURL(url) {
        var host = url.trim()
        // if the URL doesn't contain HTTP(S) then add it!
        if (!host.indexOf('http') == 0) {
            host = 'http://' + host
        }
        // if the user typed trailing '/' or "index.php", strip that
        return host.replace(/\/(index.php)?\/*$/, '')
    }

}
