import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 840
    height: 480
    title: qsTr("Hello World")

    TransactionList {
        id: transactionList
        anchors.fill: parent
    }
}
