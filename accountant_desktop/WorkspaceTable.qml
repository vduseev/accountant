import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQml 2.2

TableView {
    id: tableView

    readonly property string viewType: "abstractTable"
    // Indicated currently selected column
    property int currentColumn: -1
    property int rowHeight: 0
    property alias workerScriptSource: workspaceTableModel.workerScriptSource

    signal editRow(int modelIndex, WorkspaceTableModel model)

    function setCurrentCell(row, column) {
        currentRow = row
        currentColumn = column
    }

    // Set of methods to move through the table.
    function stepLeft() { currentColumn = Math.max(0, currentColumn - 1) }
    function stepUp() { currentRow = Math.max(0, currentRow - 1) }
    function stepRight() { currentColumn = Math.min(tableView.columnCount - 1, currentColumn + 1 ) }
    function stepDown() { currentRow = Math.min(tableView.rowCount - 1, currentRow + 1) }

    // Model belongs to this table.
    // It is instantiated together with root and populated with
    // WorkerScript inside it.
    model: workspaceTableModel

    rowDelegate: Item {
        // Bottom border of the row
        Rectangle { z: styleData.row === currentRow ? 1 : 0; anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#EEE" }
        Binding { target: tableView; property: "rowHeight"; value: height }
    }

    itemDelegate: WorkspaceTableCell {
        onEditingFinished: {
            __updateModelWithResultOfEditing(styleData.row, styleData.column, text)
            resizeColumnsToContents()
        }

        Component.onCompleted: {
            resizeColumnsToContents()
        }
    }

    selectionMode: SelectionMode.ExtendedSelection

    onDoubleClicked: {
        editRow(row, workspaceTableModel)
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Left) {
            stepLeft()
            event.accepted = true
        } else if (event.key === Qt.Key_Up) {
            stepUp()
            event.accepted = true
        } else if (event.key === Qt.Key_Right) {
            stepRight()
            event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            stepDown()
            event.accepted = true
        }
    }

    Component.onCompleted: {
        forceActiveFocus()
    }

    WorkspaceTableModel {
        id: workspaceTableModel
        onCountChanged: {
            resizeColumnsToContents()
            positionViewAtRow(count - 1, ListView.Visible)
        }
    }

    Menu {
        id: contextMenu
        MenuItem {
            text: qsTr("Edit...")
            onTriggered: editRow(currentRow, workspaceTableModel)
        }
    }

    function __getCurrentRole(columnIndex) {
        var tableViewColumn = tableView.getColumn(columnIndex)
        return tableViewColumn.role
    }

    // Returns altered element with text converted to actual JS value.
    // This method relies on keywords in role names.
    function __setElementField(element, role, value) {
        var updatedElement = element
        if (role.indexOf("date") > -1) {
            updatedElement[role] = value // value.toLocaleString(Locale.ShortFormat) - no need since everything in a model stored as a text
        } else if (role.indexOf("amount") > -1) {
            updatedElement[role] = value /* parseFloat(value) */
        } else {
            updatedElement[role] = value
        }
        return updatedElement
    }

    function __updateModelWithResultOfEditing(row, column, text) {
        // Obtain current element
        var element = workspaceTableModel.get(row)
        // Find out which role this cell is displaying
        var role = __getCurrentRole(column)
        // Set new value to the element
        var updatedElement = __setElementField(element, role, text)
        // Update the model
        workspaceTableModel.upsert(row, updatedElement)
    }
}
