import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

TableView {
    id: accountTable

    readonly property string viewType: "accountTable"

    signal doubleClickedOnTransaction(int modelIndex, ListModel model)

    function upsertTransaction(modelIndex, transaction) {
        if (modelIndex === -1) {
            addTransaction(transaction)
        } else {
            updateTransaction(transaction, modelIndex)
        }
    }

    function updateTransaction(modelIndex, transaction) {
        accountTable.model.set(modelIndex, transaction)
    }

    function addTransaction(transaction) {
        accountTable.model.append(transaction)
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
        doubleClickedOnTransaction(row, model)
    }

    TableViewColumn { role: "account_name";         title: "Name" }
    TableViewColumn { role: "account_description";  title: "Description" }

    WorkerScript {
        id: lazyDataLoader
        source: "lazyAccountLoader.js"

        onMessage: {
            var listModelItem = messageObject
            //listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
            accountTable.model.append(listModelItem)
            accountTable.resizeColumnsToContents()
        }
    }
}
