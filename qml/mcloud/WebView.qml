import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Web 0.2

WebView {
    id: root

    property QtObject signonRequest
    readonly property string token_url: "https://ose.caiyun.feixin.10086.cn/oauthApp/OAuth2/getToken"
    readonly property string redirect_url: "http://developer.ubuntu.com/en/"
    readonly property string client_id: "APP1ZtqoN3R0002"
    readonly property string client_pass: "A70EFCDC91456349E7FDECF0A33574AC"

    Component.onCompleted: {
        signonRequest.authenticated.connect(onAuthenticated)
        url = signonRequest.startUrl
    }

    //1.WORKAROUND: we need to retrieve refresh token instead of access token.
    function fetchRefreshToken(code) {
        var http = new XMLHttpRequest()
        var body = "grant_type=authorization_code&code="+code+"&redirect_uri="+redirect_url

        http.open("POST", token_url, true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Authorization", "Basic " + Qt.btoa(client_id + ":" + client_pass));
        http.onreadystatechange = function() {
            if (http.readyState === 4 && http.status == 200) {
                var response = JSON.parse(http.responseText)
                //create a fake access_token with refresh token. 
                var urlStr = redirect_url+"#access_token="+response.refresh_token
                var authUrl = Qt.resolvedUrl(urlStr);
                signonRequest.currentUrl = authUrl
            } else {
                console.log("error: " + http.status)
            }   
        };  

        http.send(body);
    } 

    onLoadingStateChanged: {
        if (loading) {
            signonRequest.onLoadStarted()
        } else if (lastLoadSucceeded) {
            signonRequest.onLoadFinished(true)
        } else {
            signonRequest.onLoadFinished(false)
        }
    }

    onUrlChanged: {
        //2.WORKAROUND: retrieve refresh token if code is fetched
        var code_pattern= new RegExp("\\?code=.*&");
        var urlStr = url.toString()
        if (code_pattern.test(urlStr)){
            var code = urlStr.match(/\?code=(.*)&/)[1];
            console.log("code::", code)
            fetchRefreshToken(code)
        } else {
            signonRequest.currentUrl = url
        }
    }

    //3.WORKAROUND: Apply desktop useragent to prevent server from detecting android client,
    //which causes authentication failure.
    context: WebContext {
        dataPath: signonRequest ? signonRequest.rootDir : ""
        userAgent: "Mozilla/5.0 (Linux; Ubuntu 14.04) AppleWebKit/537.36 Chromium/35.0.1870.2 Safari/537.36"
    }

    function onAuthenticated() {
        /* Get the cookies and set them on the request */
        console.log("Authenticated; getting cookies")
        context.cookieManager.getCookiesResponse.connect(onGotCookies)
        context.cookieManager.getAllCookies()
        visible = false
    }

    function onGotCookies(requestId, cookies) {
        signonRequest.setCookies(cookies)
    }

    /* Taken from webbrowser-app */
    ProgressBar {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: units.dp(3)
        showProgressPercentage: false
        visible: root.loading
        value: root.loadProgress / 100
    }
}
