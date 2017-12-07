import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    property var roles: []

    property alias labelText: label.text
    property alias labelFontPixelSize: label.font.pixelSize
    property alias placeholderText: textArea.placeholderText
    property alias text: textArea.text

    function getRoleValue(role) {
        return text
    }

    function setRoleValue(role, value) {
        text = value
    }

    function clear() {
        text = ""
    }

    Text {
        id: label
        anchors {
            left: parent.left
            top: parent.top
        }
    }

    TextArea {
        id: textArea
        anchors {
            left: label.left
            top: label.bottom
            topMargin: 5
            right: parent.right
            bottom: parent.bottom
        }
        background: Rectangle {
            border.width: 1
            border.color: "gray"
        }
    }
}
