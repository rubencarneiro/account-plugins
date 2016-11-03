import Ubuntu.OnlineAccounts.Plugin 1.0

OAuthMain {
    creationComponent: OAuth {
        userAgent: "Mozilla/5.0 (Linux; Ubuntu 15.04) AppleWebKit/537.36 Chromium/51.0.2704.79 Safari/537.36"

        function getFirstChildByTagName(node, name) {
            for (var i=0; i < node.childNodes.length; i++) {
                if (node.childNodes[i].tagName === name) {
                    return node.childNodes[i];
                }
            }
        }

        function getUserName(reply, callback) {
            var url = "https://ose.caiyun.feixin.10086.cn/richlifeApp/devapp/ICatalog";
            var body = "<getDisk><MSISDN>thirdparty_anonymous_account</MSISDN><catalogID>root</catalogID><startNumber>-1</startNumber></getDisk>";
            var http = new XMLHttpRequest();
            http.open("POST", url, true);
            http.setRequestHeader("Authorization", "Bearer " + reply.AccessToken);
            http.onreadystatechange = function() {
                if (http.readyState === 4) {
                    if (http.status === 200) {
                        console.log("ok: ")
                        var disk = http.responseXML.documentElement.firstChild
                        var folders = getFirstChildByTagName(disk, 'catalogList') 
                        var folder = folders.childNodes[0]
                        var owner = getFirstChildByTagName(folder, "owner") 
                        callback("Phone number: " + owner.childNodes[0].nodeValue);
                    } else {
                        console.log("error: " + http.status);
                        console.log("response text: " + http.responseText);
                        cancel();
                    }
                }
            };
            http.send(body);
            return true;
        }
    }
}
