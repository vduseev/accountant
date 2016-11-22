import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

SplitView {
    id: transactionListHeaders
    orientation: Qt.Horizontal

    property alias dateColumnWidth: dateHeader.width
    property alias fromAccountColumnWidth: fromAccountHeader.width
    property alias toAccountColumnWidth: toAccountHeader.width
    property alias descriptionColumnWidth: descriptionHeader.width
    property alias amountColumnWidth: amountHeader.width

    Rectangle {
        id: dateHeader
        width: 200
        Layout.minimumWidth: 100
        color: "lightgray"

        Text { anchors.centerIn: parent; text: "Date" }
    }

    Rectangle {
        id: fromAccountHeader
        width: 100
        Layout.minimumWidth: 100
        color: "lightgray"

        Text { anchors.centerIn: parent; text: "From" }
    }

    Rectangle {
        id: toAccountHeader
        width: 100
        Layout.minimumWidth: 100
        color: "lightgray"

        Text { anchors.centerIn: parent; text: "To" }
    }

    Rectangle {
        id: descriptionHeader
        Layout.fillWidth: true
        Layout.minimumWidth: 100
        color: "lightgray"

        Text { anchors.centerIn: parent; text: "Description" }
    }

    Rectangle {
        id: amountHeader
        width: 100
        Layout.minimumWidth: 100
        color: "lightgray"

        Text { anchors.centerIn: parent; text: "Amount" }
    }
}
