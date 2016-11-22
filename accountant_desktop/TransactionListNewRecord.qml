import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQml 2.2

Rectangle {
    id: root
    z: 2

    property int dateColumnWidth: null
    property int fromAccountColumnWidth: null
    property int toAccountColumnWidth: null
    property int descriptionColumnWidth: null
    property int amountColumnWidth: null
    property int fontPixelSize: null

    property date transactionDate: new Date()

    /* Date and Time picker */
    Item {
        id: dateColumn
        width: dateColumnWidth + 1
        z: 1
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }


        MouseArea {
            id: dateTimeArea
            anchors.fill: parent
            onClicked: {
                dateColumn.state = "select_date"
            }

            Text {
                id: dateTimeLabel
                anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                text: transactionDate.toLocaleString(Locale.ShortFormat)
                font.pixelSize: fontPixelSize
                visible: true
            }
        }

        Calendar {
            id: calendar
            anchors { left: parent.left; bottom: parent.bottom; margins: 10 }
            z: 1
            visible: false

            /* Date has been selected */
            onClicked: {
                transactionDate = date
                dateColumn.state = "" // go back to default state
            }
        }

        states: [
            State {
                name: "select_date"
                PropertyChanges { target: dateTimeLabel; visible: false }
                PropertyChanges { target: calendar; visible: true }
            }
        ]

        TransactionListColumnSeparator { }
    }

    Item {
        id: fromAccountColumn
        width: fromAccountColumnWidth + 1
        anchors { left: dateColumn.right; top: parent.top; bottom: parent.bottom }

        TextInput { id: fromAccountLabel; anchors { fill: parent; margins: 10 } font.pixelSize: fontPixelSize }
        TransactionListColumnSeparator { }
    }

    Item {
        id: toAccountColumn
        width: toAccountColumnWidth + 1
        anchors { left: fromAccountColumn.right; top: parent.top; bottom: parent.bottom }

        TextInput { id: toAccountLabel; anchors { fill: parent; margins: 10 } font.pixelSize: fontPixelSize }
        TransactionListColumnSeparator { }
    }

    Item {
        id: descriptionColumn
        width: descriptionColumnWidth + 1
        anchors { left: toAccountColumn.right; top: parent.top; bottom: parent.bottom }

        EditableText {
            id: descriptionTextField
            anchors { fill: parent }
            font.pixelSize: fontPixelSize
            placeholderText: "Transaction description"
        }

        TransactionListColumnSeparator { }
    }

    Item {
        id: amountColumn
        width: amountColumnWidth
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom }

        TextInput { id: amountLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: "0"; font.pixelSize: fontPixelSize }
        TextInput { id: curLabel; anchors { left: amountLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter } font.pixelSize: fontPixelSize }
    }
}
