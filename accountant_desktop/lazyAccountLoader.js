WorkerScript.onMessage = function(message) {
    for (var i = 1; i < 50; i++) {
        var account = {
            "account_name":         "ING Visa",
            "account_description":  "MY Poland card"
        }

        WorkerScript.sendMessage({ "messageType": "data", "data": account })
    }
    WorkerScript.sendMessage({ "messageType": "finished" })
}
