import QtQuick 2.7
import QtGraphicalEffects 1.0

Rectangle {
    id: textInputCell

    signal returnPressed()
    signal editingFinished(string text)

    z: parent.z + 1

    border.color: "#44F"
    border.width: 2

    layer.enabled: true
    layer.effect: DropShadow {
        // Z index of shadow should be the highest among all neighbor items
        z: textInputCell.z + 1
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

        // Catch return specifically to finish editing
        Keys.priority: Keys.BeforeItem
        Keys.onReturnPressed: textInputCell.returnPressed()

        onEditingFinished: textInputCell.editingFinished(text)

        // After loading TextInput should receive active focues
        Component.onCompleted: forceActiveFocus()
    }
}
