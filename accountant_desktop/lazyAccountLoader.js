WorkerScript.onMessage = function(message) {
    var xmlhttp = new XMLHttpRequest();
    var url = "https://v6uicc5ix9.execute-api.us-east-1.amazonaws.com/test/accounts";

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status === 200) {
            var items = JSON.parse(xmlhttp.responseText);
            for (var i = 0; i < items.length; i++) {
                WorkerScript.sendMessage({"messageType": "data", "data": items[i]});
            }
            WorkerScript.sendMessage({ "messageType": "finished" })
        }
    }

    xmlhttp.open("GET", url, true);
    xmlhttp.send();

//    for (var i = 0; i < 50; i++) {
//        var account = {
//            "account_name":         "ING Visa",
//            "account_currency":     "PLN",
//            "account_description":  "MY Poland card"
//        }

//        WorkerScript.sendMessage({ "messageType": "data", "data": account })
//    }
}
