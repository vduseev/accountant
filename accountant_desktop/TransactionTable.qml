import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

TableView {
    id: transactionTable

    readonly property string viewType: "transactionTable"

    signal doubleClickedOnTransaction(int modelIndex, ListModel model)

    function upsertTransaction(modelIndex, transaction) {
        if (modelIndex === -1) {
            addTransaction(transaction)
        } else {
            updateTransaction(transaction, modelIndex)
        }
    }

    function updateTransaction(modelIndex, transaction) {
        transactionTable.model.set(modelIndex, transaction)
    }

    function addTransaction(transaction) {
        transactionTable.model.append(transaction)
    }

    // ListModel belongs to TransactionTable.
    // It is instantiated together with TransactionTable and populated with
    // WorkerScript inside it.
    model: ListModel { }

    selectionMode: SelectionMode.ExtendedSelection

    Component.onCompleted: {
        lazyDataLoader.sendMessage("Load the data")
    }

    onDoubleClicked: {
        var transaction = model.get(row)
        doubleClickedOnTransaction(model, row, transaction)
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
        source: "lazyLoader.js"

        onMessage: {
            var listModelItem = messageObject
            listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
            transactionTable.model.append(listModelItem)
            transactionTable.resizeColumnsToContents()
        }
    }
}
