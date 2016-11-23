import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQml 2.2

Item {
    id: root

    property date calendarDate: null
    property int fontPixelSize: null
    property bool doubleClickTriggered: true

    MouseArea {
        id: dateTimeArea
        anchors.fill: parent

        onClicked: {
            if (!doubleClickTriggered) {
                root.state = "select_date"
            }
        }

        onDoubleClicked: {
            if (doubleClickTriggered) {
                //root.state = "select_date"
                calendarPopup.open()
            }
        }

        Text {
            id: dateTimeLabel
            anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
            text: calendarDate.toLocaleString(Locale.ShortFormat)
            font.pixelSize: fontPixelSize
            visible: true
        }
    }

    Popup {
        id: calendarPopup
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        Calendar {
            id: calendar
            anchors.fill: parent
        }
    }
}
