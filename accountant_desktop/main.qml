import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    visible: true
    width: 800//Screen.desktopAvailableWidth
    height: 600//Screen.desktopAvailableHeight
    title: qsTr("The Accountant")


    TransactionList {
        id: transactionList
        anchors.fill: parent
    }
}
