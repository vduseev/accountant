import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQml 2.2

Rectangle {
    id: calendarCell

    signal returnPressed()
    signal escapePressed()
    signal editingFinished(string text)

    implicitWidth: calendar.implicitWidth
    implicitHeight: calendar.implicitHeight
    z: 1

    color: "white"
    border.color: "#44F"
    border.width: 2

    layer.enabled: true
    layer.effect: DropShadow {
        // Z index of shadow should be the highest among all neighbor items
        z: calendarCell.z + 1
        color: "#999"
        radius: 6
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 2

    }

    Calendar {
        id: calendar
        selectedDate: Date.fromLocaleDateString(Qt.locale(), styleData.value, "MM/dd/yyyy")
        anchors.fill: parent

        onClicked: editingFinished(selectedDate.toLocaleDateString(Qt.locale(), "MM/dd/yyyy"))

        // Catch return specifically to finish editing
        //Keys.priority: Keys.BeforeItem
        //Keys.onReturnPressed: calendarCell.returnPressed()
        //Keys.onEscapePressed: { text = styleData.value; calendarCell.escapePressed() }

        //onEditingFinished: calendarCell.editingFinished(text)

        // After loading Calendar should receive active focues
        Component.onCompleted: forceActiveFocus()
    }
}
