import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.0

Rectangle {
    id: root

    width: calendar.x + calendar.width + 20
    height: calendar.y + calendar.height + 20

    //color: "white"
    //radius: 10

    property alias withdrawalAccount: withdrawalAccountTextField.text
    property alias depositAccount: depositAccountTextField.text
    property alias transactionAmount: transactionAmountTextField.text
    property alias calendarDate: calendar.selectedDate

    Text {
        id: withdrawalAccountLabel
        text: qsTr("Withdrawal Account")
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.pixelSize: 12
    }

    TextField {
        id: withdrawalAccountTextField
        width: 253
        height: 40
        text: qsTr("Text Field")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: withdrawalAccountLabel.bottom
        anchors.topMargin: 5
    }

    Text {
        id: depositAccountLabel
        text: qsTr("Deposit Account")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: withdrawalAccountTextField.bottom
        anchors.topMargin: 20
        font.pixelSize: 12
    }

    TextField {
        id: depositAccountTextField
        width: 253
        height: 40
        text: qsTr("Text Field")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: depositAccountLabel.bottom
        anchors.topMargin: 5
    }

    Text {
        id: transactionAmountLabel
        text: qsTr("Transaction Amount")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: depositAccountTextField.bottom
        anchors.topMargin: 20
        font.pixelSize: 12
    }

    TextField {
        id: transactionAmountTextField
        width: 162
        height: 40
        anchors.top: transactionAmountLabel.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 20
        placeholderText: qsTr("Text Field")
    }

    Text {
        id: transactionDateLabel
        text: qsTr("Transaction Date")
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: withdrawalAccountTextField.right
        anchors.leftMargin: 20
        font.pixelSize: 12
    }

    OldControls.Calendar {
        id: calendar
        anchors.top: transactionDateLabel.bottom
        anchors.topMargin: 5
        anchors.left: withdrawalAccountTextField.right
        anchors.leftMargin: 20
    }

    ComboBox {
        id: curComboBox
        anchors.left: transactionAmountTextField.right
        anchors.leftMargin: 0
        anchors.top: transactionAmountTextField.top
        anchors.topMargin: 0
        anchors.right: depositAccountTextField.right
        anchors.rightMargin: 0

        model: ["USD", "EUR", "PLN", "RUB"]
    }



}
