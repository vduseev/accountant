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

    /* Date and Time picker */
    Item {
        id: dateColumn
        width: dateColumnWidth + 1
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }

        CalendarField {
            id: calendarField
            anchors.fill: parent
            //z: 3
            fontPixelSize: root.fontPixelSize
            calendarDate: new Date()
        }

        TransactionListColumnSeparator { }
    }

    Item {
        id: fromAccountColumn
        width: fromAccountColumnWidth + 1
        anchors { left: dateColumn.right; top: parent.top; bottom: parent.bottom }

        LookupField {
            id: fromAccountLookup
            anchors { fill: parent }
            fontPixelSize: root.fontPixelSize
            placeholderText: "Withdrawal account"
        }

        TransactionListColumnSeparator { }
    }

    Item {
        id: toAccountColumn
        width: toAccountColumnWidth + 1
        anchors { left: fromAccountColumn.right; top: parent.top; bottom: parent.bottom }

        LookupField {
            id: toAccountLookup
            anchors { fill: parent }
            fontPixelSize: root.fontPixelSize
            placeholderText: "Deposit account"
        }

        TransactionListColumnSeparator { }
    }

    Item {
        id: descriptionColumn
        width: descriptionColumnWidth + 1
        anchors { left: toAccountColumn.right; top: parent.top; bottom: parent.bottom }

        EditableField {
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
