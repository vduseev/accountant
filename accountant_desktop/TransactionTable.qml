import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

WorkspaceTable {
    id: transactionTable

    readonly property string viewType: "transactionTable"

    Component.onCompleted: {
        lazyDataLoader.sendMessage("Load the data")
    }

    // date & time
    TableViewColumn { role: "date";             title: "Date" }

    // accounts (source, destination)
    TableViewColumn { role: "from_account";     title: "From" }
    TableViewColumn { role: "to_account";       title: "To" }

    // amounts
    TableViewColumn { role: "payment_amount";   title: "Payment Amount" }
    TableViewColumn { role: "payment_currency"; title: "Cur" }
    TableViewColumn { role: "blocked_amount";   title: "Blocked Amount" }
    TableViewColumn { role: "blocked_currency"; title: "Cur" }
    TableViewColumn { role: "actual_amount";    title: "Actual Amount" }
    TableViewColumn { role: "actual_currency";  title: "Cur" }

    // description
    TableViewColumn { role: "description";      title: "Description" }

    WorkerScript {
        id: lazyDataLoader
        source: "lazyTransactionLoader.js"

        onMessage: {
            var listModelItem = messageObject
            listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
            transactionTable.model.append(listModelItem)
            transactionTable.resizeColumnsToContents()
        }
    }
}
