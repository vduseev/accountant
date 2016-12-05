import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    property alias labelText: label.text
    property alias labelFontPixelSize: label.font.pixelSize
    property alias placeholderText: textField.placeholderText
    property alias text: textField.text

    Text {
        id: label
        anchors {
            left: parent.left
            top: parent.top
        }
    }

    TextField {
        id: textField
        anchors {
            left: label.left
            top: label.bottom
            topMargin: 5
            right: parent.right
            bottom: parent.bottom
        }
    }
}
