import QtQuick 2.0

Rectangle {
    id: root

    property int dateColumnWidth: null
    property int fromAccountColumnWidth: null
    property int toAccountColumnWidth: null
    property int descriptionColumnWidth: null
    property int amountColumnWidth: null
    property int fontPixelSize: null

    color: index % 2 == 0 ? "transparent" : "#f0f0f0"

    property int columnMargin: 0

    Item {
        id: dateColumn
        width: dateColumnWidth + 1
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }

        Text { id: dateLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: date; font.pixelSize: fontPixelSize }
        Rectangle { height: parent.height; width: 1; anchors { right: parent.right; verticalCenter: parent.verticalCenter } color: "lightgray" }
    }

    Item {
        id: fromAccountColumn
        width: fromAccountColumnWidth + 1
        anchors { left: dateColumn.right; leftMargin: columnMargin; top: parent.top; bottom: parent.bottom }

        Text { id: fromAccountLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: from_account; font.pixelSize: fontPixelSize }
        Rectangle { height: parent.height; width: 1; anchors { right: parent.right; verticalCenter: parent.verticalCenter } color: "lightgray" }
    }

    Item {
        id: toAccountColumn
        width: toAccountColumnWidth + 1
        anchors { left: fromAccountColumn.right; leftMargin: columnMargin; top: parent.top; bottom: parent.bottom }

        Text { id: toAccountLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: to_account; font.pixelSize: fontPixelSize }
        Rectangle { height: parent.height; width: 1; anchors { right: parent.right; verticalCenter: parent.verticalCenter } color: "lightgray" }
    }

    Item {
        id: descriptionColumn
        width: descriptionColumnWidth + 1
        anchors { left: toAccountColumn.right; leftMargin: columnMargin; top: parent.top; bottom: parent.bottom }

        Text { id: descriptionLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: description; font.pixelSize: fontPixelSize }
        Rectangle { height: parent.height; width: 1; anchors { right: parent.right; verticalCenter: parent.verticalCenter } color: "lightgray" }
    }

    Item {
        id: amountColumn
        width: amountColumnWidth
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom }

        Text { id: amountLabel; anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter } text: amount; font.pixelSize: fontPixelSize }
        Text { id: curLabel; anchors { left: amountLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter } text: cur; font.pixelSize: fontPixelSize }
    }

    Rectangle {
        width: parent.width; height: 1;
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
        color: "lightgray";
    }
}
