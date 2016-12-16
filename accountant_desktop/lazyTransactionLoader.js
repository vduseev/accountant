WorkerScript.onMessage = function(message) {
    for (var i = 1; i < 50; i++) {
        var transaction = {
            "date": new Date("November " + (i % 30 + 1) + ", 2016 03:24:00"), //.toLocaleString(QtCommon.Locale.ShortFormat),

            "from_account":     "ING Visa",
            "to_account":       "JetBrains",

            "payment_amount":       Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10,
            "payment_currency":     "PLN",
            "blocked_amount":       Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10,
            "blocked_currency":     "PLN",
            "actual_amount":        Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10,
            "actual_currency":      "PLN",

            "description": "Monthly subscription"
        }

        WorkerScript.sendMessage(transaction)
    }

    for (var j = 1; j < 5; j++) {
        var bip = {
            "date": new Date(),
            "from_account": "",
            "to_account": "",
            "payment_amount":       0,
            "payment_currency":     "",
            "blocked_amount":       0,
            "blocked_currency":     "",
            "actual_amount":        0,
            "actual_currency":      "",

            "description": ""
        }

        WorkerScript.sendMessage(bip)
    }
}
