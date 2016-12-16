import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQml 2.2

TableView {
    id: tableView

    readonly property string viewType: "abstractTable"
    // Indicated currently selected column
    property int currentColumn: -1
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
    }

    itemDelegate: MouseArea {
        id: itemArea

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
            id: cellValueEditor
            anchors.fill: parent
            z: itemArea.z + 1
            active: false
            asynchronous: true
            sourceComponent: Rectangle {
                id: cellBackground
                z: cellValueEditor.z + 1
                border.color: "#44F"
                border.width: 2
                layer.enabled: true
                layer.effect: DropShadow {
                    // Z index of shadow should be the highest among all neighbor items
                    z: cellBackground.z + 1
                    color: "#999"
                    radius: 6
                    transparentBorder: true
                    horizontalOffset: 2
                    verticalOffset: 2

                }

                TextInput {
                    text: styleData.value
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    // Catch return specifically to finish editing
                    Keys.priority: Keys.BeforeItem
                    Keys.onReturnPressed: {
                        stepDown()
                    }

                    onEditingFinished: updateModelWithResultOfEditing()

                    // After loading TextInput should receive active focues
                    Component.onCompleted: forceActiveFocus()

                    function updateModelWithResultOfEditing() {
                        // Obtain current element
                        var element = __getElement(styleData.row)
                        // Find out which role this cell is displaying
                        var role = __getCurrentRole(styleData.column)
                        // Set new value to the element
                        var updatedElement = __setElementField(element, role, text)
                        // Update the model
                        upsert(styleData.row, updatedElement)
                    }
                }
            }
        }

        Connections {
            target: tableView
            onCurrentColumnChanged: {
                if (cellValueEditor.active && styleData.column !== currentColumn) {
                    cellText.visible = true
                    cellValueEditor.active = false
                }
            }
            onCurrentRowChanged: {
                if (cellValueEditor.active && styleData.row !== currentRow) {
                    cellText.visible = true
                    cellValueEditor.active = false
                }
            }
        }

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
            cellText.visible = false
            cellValueEditor.active = true
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
        onMessage: workerScriptMessage(messageObject)
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
