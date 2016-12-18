import QtQuick 2.7

Item {
    id: cellDelegate

    property int zIncrementForRow: styleData.row === currentRow ? 1 : 0
    property int zIncrementForColumn: styleData.column === currentColumn ? 1 : 0

    signal editingFinished(string text)

    // implicitWidth is required for call of function resizeToContents() of TableViewColumn
    implicitWidth: cellText.width + 2 * cellText.anchors.leftMargin

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
        onEditingFinished: cellDelegate.editingFinished(text)
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
