WorkerScript.onMessage = function(message) {
    var xmlhttp = new XMLHttpRequest();
    var url = "https://v6uicc5ix9.execute-api.us-east-1.amazonaws.com/test/transactions";

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status === 200) {
            var items = JSON.parse(xmlhttp.responseText);
            for (var i = 0; i < items.length; i++) {
                var paymentDate = (new Date(items[i].payment_date * 1000)).toLocaleString("MM/dd/yyyy");
                var processingDate = (new Date(items[i].processing_date * 1000)).toLocaleString("MM/dd/yyyy");
                var transaction = {
                    "from_account":         items[i].from_account.name,
                    "to_account":           items[i].to_account.name,
                    "description":          items[i].description,
                    "payment_date":         paymentDate,
                    "payment_amount":       items[i].payment_amount,
                    "payment_currency":     items[i].payment_currency,
                    "processing_amount":    items[i].processing_amount,
                    "processing_date":      processingDate

                }
                WorkerScript.sendMessage({"messageType": "data", "data": transaction});
            }
            WorkerScript.sendMessage({ "messageType": "finished" })
        }
    }

    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}
