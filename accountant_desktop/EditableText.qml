import QtQuick 2.0
import QtQuick.Controls 2.0

TextField {
    id: editableTextField
    background: Rectangle {
        color: editableTextField.focus == true ? "#f0f0f0" : "white"

        Rectangle {
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            color: "transparent"
            border.color: "#21be2b"
            visible: editableTextField.focus
        }
    }
}
