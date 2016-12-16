import QtQuick 2.0
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQml 2.2

TableView {
    id: tableView

    readonly property string viewType: "abstractTable"
    // Indicated currently selected column
    property int currentColumn: -1
    property alias workerScriptSource: lazyDataLoader.source

    signal openCell(int modelIndex, ListModel model)
    signal rowDoubleClicked(int modelIndex, ListModel model)
    signal workerScriptMessage(var message)

    function setCurrentCell(row, column) {
        currentRow = row
        currentColumn = column
    }

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

    rowDelegate: Item {
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#EEE" }
    }

    itemDelegate: MouseArea {
        id: itemArea

        // Right corner border
        Rectangle { anchors.right: parent.right; width: 1; height: parent.height; color: "#EEE" }
        // Bottom border
        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#EEE" }

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
            z: 900
            active: false
            asynchronous: true
            sourceComponent: Rectangle {
                border.color: "#44F"
                border.width: 2
                layer.enabled: true
                layer.effect: DropShadow {
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

                    onActiveFocusChanged: {
                        console.log("focus:", activeFocus)
                    }

                    Component.onCompleted: forceActiveFocus()
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
            if (mouse.button === Qt.LeftButton) {
                // Select clicked cell
                setCurrentCell(styleData.row, styleData.column)
            } else if (mouse.button === Qt.RightButton) {
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
            onTriggered: openCell(currentRow, model)
        }
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
