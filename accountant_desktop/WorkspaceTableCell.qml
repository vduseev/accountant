import QtQuick 2.7

Item {
    id: cellDelegate

    property int zIncrementForRow: styleData.row === currentRow ? 1 : 0
    property int zIncrementForColumn: styleData.column === currentColumn ? 1 : 0

    signal editingFinished(string text)

    // implicitWidth is required for call of function resizeToContents() of TableViewColumn
    implicitWidth: cellTextMetrics.width + 2 * cellText.anchors.leftMargin + cellText.anchors.rightMargin

    // Z index is incremented for current cell, so that it's shadow overlaps neighbor cells
    z: zIncrementForRow + zIncrementForColumn

    // Focus is required to trigger forceActiveFocus. But only one cell can be active at a time
    focus: styleData.row === currentRow && styleData.column === currentColumn
    // React to key pressed and invoke cell editor
    Keys.onPressed: {
        if (event.key >= 0x41 && event.key <= 0x5a ||
            event.key >= 0x30 && event.key <= 0x39 ||
            event.key === Qt.Key_F2)
        {
            cellEditorLoader.active = true
            event.accepted = true
        }
    }

    onFocusChanged: {
        if (focus) {
            // Force active focus to be able to accept key presses and active view using them
            forceActiveFocus()
        }
    }

    // Right corner border
    Rectangle { z: 0; anchors.right: parent.right; width: 1; height: parent.height; color: "#EEE" }

    // Selection border
    Rectangle {
        anchors.fill: parent
        visible: styleData.row === currentRow && styleData.column === currentColumn
        border.color: "#44F"
        border.width: 2
    }

    TextMetrics {
        id: cellTextMetrics
        text: cellText.text
        font: cellText.font
        elideWidth: cellText.width
        elide: Text.ElideRight
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
            right: parent.right
            rightMargin: 10
        }
    }

    Loader {
        id: cellEditorLoader
        anchors.fill: parent
        z: cellDelegate.z + 1
        active: false
        asynchronous: true
        source: "TextInputCell.qml"
        Keys.forwardTo: [cellDelegate]
    }

    Connections {
        target: cellEditorLoader.item
        onReturnPressed: cellEditorLoader.active = false
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
