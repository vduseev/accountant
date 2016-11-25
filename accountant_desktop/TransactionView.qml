import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.0
import QtQml 2.2

Rectangle {
    id: root

    width: transactionDateCalendar.x + transactionDateCalendar.width + 20
    height: submitButton.y + submitButton.height + 20

    //color: "white"
    //radius: 10

    signal submit(var transaction, var modelIndex)
    signal cancel()

    property int modelIndex: -1

    Text {
        id: fromAccountLabel
        text: qsTr("From Account")
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.pixelSize: 12
    }

    TextField {
        id: fromAccountTextField
        width: 253
        height: 40
        placeholderText: "Specify withdrawal account..."
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: fromAccountLabel.bottom
        anchors.topMargin: 5
    }

    Text {
        id: toAccountLabel
        text: qsTr("To Account")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: fromAccountTextField.bottom
        anchors.topMargin: 20
        font.pixelSize: 12
    }

    TextField {
        id: toAccountTextField
        width: 253
        height: 40
        placeholderText: "Specify deposit account..."
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: toAccountLabel.bottom
        anchors.topMargin: 5
    }

    Text {
        id: transactionAmountLabel
        text: qsTr("Transaction Amount")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: toAccountTextField.bottom
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
        placeholderText: qsTr("Specify amount...")
    }

    Text {
        id: transactionDateLabel
        text: qsTr("Transaction Date")
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: fromAccountTextField.right
        anchors.leftMargin: 20
        font.pixelSize: 12
    }

    OldControls.Calendar {
        id: transactionDateCalendar
        anchors.top: transactionDateLabel.bottom
        anchors.topMargin: 5
        anchors.left: fromAccountTextField.right
        anchors.leftMargin: 20
    }

    TextField {
        id: transactionCurrencyTextField
        anchors.left: transactionAmountTextField.right
        anchors.top: transactionAmountTextField.top
        anchors.right: toAccountTextField.right
        placeholderText: "USD"
        //model: ["USD", "EUR", "PLN", "RUB"]
    }

    Text {
        id: descriptionLabel
        text: qsTr("Description")
        anchors.top: transactionAmountTextField.bottom
        anchors.topMargin: 40
        anchors.leftMargin: 20
        anchors.left: parent.left
        font.pixelSize: 12
    }

    TextArea {
        id: transactionDescriptionTextArea
        height: 119
        anchors.right: transactionDateCalendar.right
        anchors.rightMargin: 0
        placeholderText: "Transaction description..."
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: descriptionLabel.bottom
        anchors.topMargin: 5
    }

    Button {
        id: submitButton
        width: 100
        height: 30
        text: qsTr("Submit")
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: transactionDescriptionTextArea.bottom
        anchors.topMargin: 20
        onClicked: {
            var transaction = getTransactionFromFields()
            submit(transaction, modelIndex)
        }
    }

    Button {
        id: cancelButton
        y: 4
        width: 100
        height: 30
        text: qsTr("Cancel")
        anchors.left: submitButton.right
        anchors.leftMargin: 20
        anchors.topMargin: 20
        anchors.top: transactionDescriptionTextArea.bottom
        onClicked: {
            cancel()
        }
    }

    function setupTransactionView(transaction, modelIndex) {
        setFieldsUsingExistingTransaction(transaction)
        root.modelIndex = modelIndex
    }

    function clearTransactionView() {
        cleanUpFields()
        root.modelIndex = -1
    }

    function setFieldsUsingExistingTransaction(transaction) {
        transactionDateCalendar.selectedDate = Date.fromLocaleString(Qt.locale(), transaction.date, Locale.ShortFormat)
        fromAccountTextField.text = transaction.from_account
        toAccountTextField.text = transaction.to_account
        transactionDescriptionTextArea.text = transaction.description
        transactionAmountTextField.text = transaction.amount
        transactionCurrencyTextField.text = transaction.cur
    }

    function cleanUpFields() {
        transactionDateCalendar.selectedDate = new Date()
        fromAccountTextField.text = ""
        toAccountTextField.text = ""
        transactionDescriptionTextArea.text = ""
        transactionAmountTextField.text = ""
        transactionCurrencyTextField.text = ""
    }

    function getTransactionFromFields() {
        var transaction = {
            "date": transactionDateCalendar.selectedDate.toLocaleString(Locale.ShortFormat),
            "from_account": fromAccountTextField.text,
            "to_account": toAccountTextField.text,
            "description": transactionDescriptionTextArea.text,
            "amount": parseFloat(transactionAmountTextField.text),
            "cur": transactionCurrencyTextField.text
        }
        return transaction
    }
}
