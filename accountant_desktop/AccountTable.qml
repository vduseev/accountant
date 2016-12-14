import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

WorkspaceTable {
    id: accountTable

    readonly property string viewType: "accountTable"

    Component.onCompleted: {
        lazyDataLoader.sendMessage("Load the data")
    }

    TableViewColumn { role: "account_name";         title: "Name" }
    TableViewColumn { role: "account_description";  title: "Description" }

    WorkerScript {
        id: lazyDataLoader
        source: "lazyAccountLoader.js"

        onMessage: {
            var listModelItem = messageObject
            accountTable.model.append(listModelItem)
            accountTable.resizeColumnsToContents()
        }
    }
}