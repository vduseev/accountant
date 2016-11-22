import QtQuick 2.0
import QtQuick.Window 2.2

Item {
    id: root

    property int fontPixelSize: null
    property string placeholderText: null

    EditableText {
        id: lookupText
        anchors.fill: parent
        font.pixelSize: fontPixelSize
        placeholderText: root.placeholderText

        onTextChanged: {
            lookupListView.visible = true

            if (text.length == 0) lookupListView.visible = false
        }

        onEditingFinished: {
            lookupListView.visible = false
        }
    }

    ListView {
        id: lookupListView
        anchors { left: parent.left; top: lookupText.bottom; right: parent.right }
        //anchors { left: parent.left; bottom: lookupText.top; right: parent.right }
        z: 2

        model: lookupMockModel
        visible: false

        delegate: Text { text: account; font.pixelSize: fontPixelSize }
        highlight: Rectangle { color: "#f0f0f0"; radius: 5 }

        onCurrentIndexChanged: {
            //lookupText.text = lookupMockModel.get(currentIndex).account
        }
    }

    ListModel {
        id: lookupMockModel
        Component.onCompleted: {
            for (var i = 1; i < 7; i++) {
                lookupMockModel.append({"account": i + " Account" })
            }
        }
    }
}
