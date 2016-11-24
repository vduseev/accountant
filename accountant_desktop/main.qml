import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    visible: true
    width: 800//Screen.desktopAvailableWidth
    height: 600//Screen.desktopAvailableHeight
    title: qsTr("The Accountant")

//    TransactionList {
//        id: transactionList
//        anchors.fill: parent
//        model: transactionListMockModel
//    }

    TransactionTable {
        id: transactionTable
        anchors.fill: parent
        model: transactionListMockModel
    }

    ListModel {
        id: transactionListMockModel
        Component.onCompleted: loadMockData()
    }

    function loadMockData() {
        for (var i = 1; i < 200; i++) {
            transactionListMockModel.append({
                "date": "November " + (i % 30 + 1) + ", 2016 03:24:00",
                "from_account": "ING Visa",
                "to_account": "JetBrains",
                "description": "Monthly subscription",
                "amount": 546.38,
                "cur": "PLN"
            })
        }
    }
}
