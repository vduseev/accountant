import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml 2.2

Item {
    id: root

    property var roles: []

    property alias labelText: label.text
    property alias labelFontPixelSize: label.font.pixelSize
    property alias selectedDate: calendar.selectedDate

    function getRoleValue(role) {
        return selectedDate.toLocaleDateString(Qt.locale(), "MM/dd/yyyy")
    }

    function setRoleValue(role, value) {
        selectedDate = Date.fromLocaleDateString(Qt.locale(), value, "MM/dd/yyyy")
    }

    function clear() {
        calendar.selectedDate = new Date()
    }

    implicitWidth: calendar.implicitWidth
    implicitHeight: calendar.implicitHeight + calendar.anchors.topMargin + label.implicitHeight

    Text {
        id: label
        anchors {
            left: root.left
            top: root.top
        }
    }

    Calendar {
        id: calendar
        anchors {
            left: label.left
            top: label.bottom
            topMargin: 5
            right: parent.right
            bottom: parent.bottom
        }
    }
}
