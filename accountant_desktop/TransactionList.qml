import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Item {
    id: root

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

        footer: Item {
            width: parent.width
            height: 30

            Button {
                anchors.fill: parent
                text: "Add Transaction"
                onClicked: console.log(4 % 2)
            }
        }
    }

    ListModel {
        id: transactionListModel
    }

    ListModel {
        id: transactionListMockModel
        ListElement { date: "Mon 21 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Tue 22 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Wed 23 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Thu 24 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Fri 25 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Sat 26 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Sun 27 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Sun 27 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Mon 28 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Mon 28 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Tue 29 Nov 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Fri 01 Dec 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Mon 04 Dec 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
        ListElement { date: "Wed 05 Dec 04:27"; from_account: "ING Visa"; to_account: "JetBrains"; description: "Monthly subscription"; amount: 546.34; cur: "PLN" }
    }
}
