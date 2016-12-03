WorkerScript.onMessage = function(message) {
    for (var i = 1; i < 200; i++) {
        WorkerScript.sendMessage({
            "date": new Date("November " + (i % 30 + 1) + ", 2016 03:24:00"), //.toLocaleString(QtCommon.Locale.ShortFormat),
            "from_account": "ING Visa",
            "to_account": "JetBrains",
            "description": "Monthly subscription",
            "amount": Math.round((Math.random()-0.5) * i) + 546.38 + i - i/10,
            "cur": "PLN"
        })
    }
}
