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
    property alias workerScriptSource: lazyDataLoader.source

    signal editRow(int modelIndex, ListModel model)
    signal workerScriptMessage(var message)

    function setCurrentCell(row, column) {
        currentRow = row
        currentColumn = column
    }

    // Set of methods to move through the table.
    function stepLeft() { currentColumn = Math.max(0, currentColumn - 1) }
    function stepUp() { currentRow = Math.max(0, currentRow - 1) }
    function stepRight() { currentColumn = Math.min(tableView.columnCount - 1, currentColumn + 1 ) }
    function stepDown() { currentRow = Math.min(tableView.rowCount - 1, currentRow + 1) }

    function upsert(modelIndex, element) {
        if (modelIndex === -1) {
            __addElement(element)
        } else {
            __updateElement(modelIndex, element)
        }
    }

    function __updateElement(modelIndex, element) {
        model.set(modelIndex, element)
    }

    function __addElement(element) {
        model.append(element)
    }

    function __getElement(modelIndex) {
        return model.get(modelIndex)
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
            updatedElement[role] = value.toLocaleString(Locale.ShortFormat)
        } else if (role.indexOf("amount") > -1) {
            updatedElement[role] = parseFloat(value)
        } else {
            updatedElement[role] = value
        }
        return updatedElement
    }

    // ListModel belongs to this table.
    // It is instantiated together with root and populated with
    // WorkerScript inside it.
    model: ListModel {
        onCountChanged: {
            resizeColumnsToContents()
            positionViewAtRow(count - 1, ListView.Visible)
        }
    }

    rowDelegate: Item {
        // Bottom border of the row
        Rectangle { z: styleData.row === currentRow ? 1 : 0; anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#EEE" }
        Binding { target: tableView; property: "rowHeight"; value: height }
    }

    itemDelegate: Item {
        id: cellDelegate

        property int zIncrementForRow: styleData.row === currentRow ? 1 : 0
        property int zIncrementForColumn: styleData.column === currentColumn ? 1 : 0

        // Z index is incremented for current cell, so that it's shadow overlaps neighbor cells
        z: zIncrementForRow + zIncrementForColumn

        // Right corner border
        Rectangle { z: 0; anchors.right: parent.right; width: 1; height: parent.height; color: "#EEE" }

        // Selection border
        Rectangle {
            anchors.fill: parent
            visible: styleData.row === currentRow && styleData.column === currentColumn
            border.color: "#44F"
            border.width: 2
        }

        Text {
            id: cellText
            text: styleData.value
            color: "black"
            elide: styleData.elideMode
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
        }

        Loader {
            id: cellEditorLoader
            anchors.fill: parent
            z: cellDelegate.z + 1
            active: false
            asynchronous: true
            source: "TextInputCell.qml"
        }

        Connections {
            target: cellEditorLoader.item
            onReturnPressed: stepDown()
            onEscapePressed: cellEditorLoader.active = false
            onEditingFinished: updateModelWithResultOfEditing(text)
        }

        Connections {
            target: tableView
            onCurrentColumnChanged: {
                if (cellEditorLoader.active && styleData.column !== currentColumn) {
                    cellEditorLoader.active = false
                }
            }
            onCurrentRowChanged: {
                if (cellEditorLoader.active && styleData.row !== currentRow) {
                    cellEditorLoader.active = false
                }
            }
        }

        function updateModelWithResultOfEditing(text) {
            // Obtain current element
            var element = __getElement(styleData.row)
            // Find out which role this cell is displaying
            var role = __getCurrentRole(styleData.column)
            // Set new value to the element
            var updatedElement = __setElementField(element, role, text)
            // Update the model
            upsert(styleData.row, updatedElement)
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                // Select clicked cell
                setCurrentCell(styleData.row, styleData.column)
                if (mouse.button === Qt.RightButton) {
                    // Open context menu
                    contextMenu.popup()
                }
            }
            onDoubleClicked: {
                cellEditorLoader.active = true
            }
        }
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Edit...")
            onTriggered: editRow(currentRow, model)
        }
    }

    WorkerScript {
        id: lazyDataLoader
        onMessage: {
            if (messageObject.messageType === "data") {
                workerScriptMessage(messageObject.data)
            } else if (messageObject.messageType === "finished") {
                // add enough empty rows
                var viewHeight = tableView.height
                var bufferRowsCount = (viewHeight / rowHeight) - 4
                for (var i = 0; i < bufferRowsCount; i++) {
                    var bufferElement = {}
                    for (var j = 0; j < columnCount; j++) {
                        var columnRole = getColumn(j).role
                        bufferElement[columnRole] = ""
                    }

                    __addElement(bufferElement)
                }
            }
        }
    }

    selectionMode: SelectionMode.ExtendedSelection

    onDoubleClicked: {
        editRow(row, model)
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Left) {
            stepLeft()
        } else if (event.key === Qt.Key_Up) {
            stepUp()
        } else if (event.key === Qt.Key_Right) {
            stepRight()
        } else if (event.key === Qt.Key_Down) {
            stepDown()
        }

        event.accepted = true
    }

    Component.onCompleted: {
        lazyDataLoader.sendMessage('load data')
        forceActiveFocus()
    }
}
