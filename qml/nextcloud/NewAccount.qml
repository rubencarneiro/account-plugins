import QtQuick 2.9
import Ubuntu.Components 1.3
import Ubuntu.OnlineAccounts 0.1

Item {
    id: root

    signal finished

    height: contents.height

    property var __account: account
    property string __host: ""
    property bool __busy: false
    property string __hostError: i18n.dtr("account-plugins", "Invalid host URL")
    property string __usernameError: i18n.dtr("account-plugins", "Invalid username or password")

    Column {
        id: contents
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }
        spacing: units.gu(2)

        Label {
            id: errorLabel
            anchors { left: parent.left; right: parent.right }
            font.bold: true
            color: theme.palette.normal.negative
            wrapMode: Text.Wrap
            visible: !__busy && text != ""
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            text: i18n.dtr("account-plugins", "URL:")
        }

        TextField {
            id: urlField
            anchors { left: parent.left; right: parent.right }
            placeholderText: i18n.dtr("account-plugins", "https://myserver.com/nextcloud")
            focus: true
            enabled: !__busy

            inputMethodHints: Qt.ImhUrlCharactersOnly + Qt.ImhNoAutoUppercase + Qt.ImhPreferLowercase + Qt.ImhNoPredictiveText
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
            inputMethodHints: Qt.ImhNoAutoUppercase + Qt.ImhNoPredictiveText + Qt.ImhPreferLowercase

            KeyNavigation.tab: passwordField
        }

        Label {
            anchors { left: parent.left; right: parent.right }
            text: i18n.dtr("account-plugins", "Password:")
        }

        TextField {
            id: passwordField
            anchors { left: parent.left; right: parent.right }
            placeholderText: i18n.dtr("account-plugins", "Your password")
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
                text: i18n.dtr("account-plugins", "Cancel")
                width: (parent.width / 2) - 0.5 * parent.spacing
                onClicked: finished()
            }
            Button {
                id: btnContinue
                text: i18n.dtr("account-plugins", "Continue")
                color: theme.palette.normal.positive
                width: (parent.width / 2) - 0.5 * parent.spacing
                onClicked: login()
                enabled: !__busy
            }
        }
    }

    ActivityIndicator {
        anchors.centerIn: parent
        running: __busy
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
        __host = cleanUrl(urlField.text)
        var username = usernameField.text
        var password = passwordField.text

        errorLabel.text = ""
        __busy = true
        var host = __host
        var tryHttp = false
        if (__host.indexOf("http") != 0) {
            host = "https://" + __host
            tryHttp = true
        }

        checkAccount(host, username, password, function cb(success) {
            console.log("callback called: " + success)
            if (success) {
                saveData(host, username, password)
            } else if (tryHttp) {
                host = "http://" + __host
                tryHttp = false
                checkAccount(host, username, password, cb)
            } else {
                __busy = false
            }
        })
    }

    function saveData(host, username, password) {
        __host = host
        var strippedHost = __host.replace(/^https?:\/\//, '')
        account.updateDisplayName(username + '@' + strippedHost)
        creds.userName = username
        creds.secret = password
        creds.sync()
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
        console.log("Trying host " + host + " as " + username + ':' + password)
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                console.log("response: " + request.responseText)
                if (request.status == 200) {
                    var root = request.responseXML ? request.responseXML.documentElement : null
                    var metaElement = findChild(root, "meta")
                    var statusElement = findChild(metaElement, "status")
                    if (statusElement && statusElement.childNodes.length > 0 &&
                        statusElement.childNodes[0].nodeValue == "ok") {
                        callback(true)
                    } else {
                        var statusCodeElement = findChild(metaElement, "statuscode")
                        var statusCode = (statusCodeElement && statusCodeElement.childNodes.length > 0) ?
                            statusCodeElement.childNodes[0].nodeValue : "999"
                        if (statusCode == "999") {
                            showError(__hostError)
                        } else {
                            showError(__usernameError)
                        }
                        callback(false)
                    }
                } else {
                    if (request.status == 401) {
                        showError(__usernameError)
                    } else {
                        showError(__hostError)
                    }
                    callback(false)
                }
            }
        }
        var url = host + "/ocs/v2.php/cloud/user";
        request.open("GET", url, true);
        request.setRequestHeader("Authorization", "Basic " + Qt.btoa(username + ":" + password));
        request.setRequestHeader("OCS-APIRequest", "true");
        request.send(null);
    }

    function showError(message) {
        if (!errorLabel.text) errorLabel.text = message
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
        __busy = false
    }

    // check host url for http
    function cleanUrl(url) {
        var host = url.trim()
        // if the user typed trailing '/' or "index.php", strip that
        return host.replace(/\/(index.php)?\/*$/, '')
    }

}
