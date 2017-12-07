import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

WorkspaceTable {
    id: accountTable

    readonly property string viewType: "accountTable"

    TableViewColumn { role: "name";         title: "Name" }
    TableViewColumn { role: "currency";     title: "CUR" }
    TableViewColumn { role: "description";  title: "Description" }

    workerScriptSource: "lazyAccountLoader.js"
}
