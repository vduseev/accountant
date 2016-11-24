import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: root
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

        onDoubleClicked: {
            var transaction = transactionListMockModel.get(row)
            transactionView.withdrawalAccount = transaction.from_account
            transactionView.depositAccount = transaction.to_account
            transactionView.calendarDate = new Date(transaction.date)
            transactionView.transactionAmount = transaction.amount

            popup.open()
        }
    }

    Popup {
        id: popup
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape

        //width: transactionView.width
        //height: transactionView.height

        x: root.width / 2 - transactionView.width / 2
        y: root.height / 2 - transactionView.height / 2

        TransactionView {
            id: transactionView
        }
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
