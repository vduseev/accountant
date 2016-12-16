import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

TableView {
    id: tableView

    readonly property string viewType: "abstractTable"
    property alias workerScriptSource: lazyDataLoader.source

    signal rowDoubleClicked(int modelIndex, ListModel model)
    signal workerScriptMessage(var message)

    function upsert(modelIndex, element) {
        if (modelIndex === -1) {
            __addElement(element)
        } else {
            __updateElement(modelIndex, element)
        }
    }

    function __updateElement(modelIndex, element) {
        tableView.model.set(modelIndex, element)
    }

    function __addElement(element) {
        tableView.model.append(element)
    }

    // ListModel belongs to this table.
    // It is instantiated together with root and populated with
    // WorkerScript inside it.
    model: ListModel {
        onCountChanged: {
            tableView.resizeColumnsToContents()
            positionViewAtRow(count - 1, ListView.Visible)
        }
    }

    selectionMode: SelectionMode.ExtendedSelection

    onDoubleClicked: {
        rowDoubleClicked(row, model)
    }

    Component.onCompleted: lazyDataLoader.sendMessage('load data')

    WorkerScript {
        id: lazyDataLoader
        onMessage: workerScriptMessage(messageObject)
    }
}
