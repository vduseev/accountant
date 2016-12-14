import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

TableView {
    id: tableView

    readonly property string viewType: "abstractTable"

    signal rowDoubleClicked(int modelIndex, ListModel model)

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
    model: ListModel { }

    selectionMode: SelectionMode.ExtendedSelection

    onDoubleClicked: {
        rowDoubleClicked(row, model)
    }
}
