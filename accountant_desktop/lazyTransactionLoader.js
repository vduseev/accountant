WorkerScript.onMessage = function(message) {
    for (var i = 0; i < 50; ++i) {
        var day = i % 29 + 1
        var dayString = day < 10 ? "0" : ""
        dayString += day.toString()
        var transaction = {
            "date": "11/" + dayString + "/2016",

            "from_account":     "ING Visa",
            "to_account":       "JetBrains",

            "payment_amount":       (Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10).toString(),
            "payment_currency":     "PLN",
            "blocked_amount":       (Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10).toString(),
            "blocked_currency":     "PLN",
            "actual_amount":        (Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10).toString(),
            "actual_currency":      "PLN",

            "description": "Monthly subscription"
        }

        WorkerScript.sendMessage({ "messageType": "data", "data": transaction })
    }

    WorkerScript.sendMessage({ "messageType": "finished"})
}
