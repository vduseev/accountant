import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

WorkspaceTable {
    id: accountTable

    readonly property string viewType: "accountTable"

    TableViewColumn { role: "account_name";         title: "Name" }
    TableViewColumn { role: "account_description";  title: "Description" }

    workerScriptSource: "lazyAccountLoader.js"

    onWorkerScriptMessage: {
        var listModelItem = message
        accountTable.model.append(listModelItem)
        accountTable.resizeColumnsToContents()
    }
}
