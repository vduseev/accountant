import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Item {
    id: root

    property string dateFormat: "value"

    TransactionListHeaders {
        id: transactionListHeaders
        height: 30
        anchors { left: parent.left; top: parent.top; right: parent.right }
    }

    ListView {
        id: transactionListView
        model: transactionListMockModel
        anchors { left: parent.left; top: transactionListHeaders.bottom; right: parent.right; bottom: parent.bottom }
        clip: true
        footerPositioning: ListView.InlineFooter

        delegate: TransactionListDelegate {
            height: 30
            width: parent.width

            dateColumnWidth: transactionListHeaders.dateColumnWidth
            fromAccountColumnWidth: transactionListHeaders.fromAccountColumnWidth
            toAccountColumnWidth: transactionListHeaders.toAccountColumnWidth
            descriptionColumnWidth: transactionListHeaders.descriptionColumnWidth
            amountColumnWidth: transactionListHeaders.amountColumnWidth
            fontPixelSize: 14
        }

        footer: TransactionListNewRecord {
            height: 30
            width: parent.width

            dateColumnWidth: transactionListHeaders.dateColumnWidth
            fromAccountColumnWidth: transactionListHeaders.fromAccountColumnWidth
            toAccountColumnWidth: transactionListHeaders.toAccountColumnWidth
            descriptionColumnWidth: transactionListHeaders.descriptionColumnWidth
            amountColumnWidth: transactionListHeaders.amountColumnWidth
            fontPixelSize: 14
        }

        Component.onCompleted: positionViewAtEnd()
    }

    ListModel {
        id: transactionListModel
    }

    ListModel {
        id: transactionListMockModel
        Component.onCompleted: loadMockData()
    }

    function loadMockData() {
        for (var i = 1; i < 20; i++) {
            transactionListMockModel.append({
                "date": "November " + i + ", 2016 03:24:00",
                "from_account": "ING Visa",
                "to_account": "JetBrains",
                "description": "Monthly subscription",
                "amount": 546.38,
                "cur": "PLN"
            })
        }
    }
}
