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
}
