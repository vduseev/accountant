import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.0
import QtQml 2.2
import QtQuick.Layouts 1.1

Rectangle {
    id: transactionView

    readonly property string viewType: "transactionView"

    // model is set when TransactionView is instantiated from
    // TransactionTable, so it is shared between TransactionTable
    // and TransactionView.
    // If TransactionTable will be closed model will be preserved.
    property ListModel model

    // modelIndex is set when TransactionView is instantiated.
    // It is used when submit signal is emitted as parameter to signal.
    // Also it is used in __updateModelWithTransaction function as part
    // of the logic to determine whether we add a new item to the model
    // or update an existing one.
    property int modelIndex: -1
    property int textFieldHeight: 50

    signal submit(int modelIndex, var transaction)
    signal cancel()

    function setupView(modelIndex, model) {
        transactionView.model = model
        if (modelIndex !== -1) {
            var transaction = model.get(modelIndex)
            transactionView.modelIndex = modelIndex
            transactionView.__setFieldsUsingExistingTransaction(transaction)
        }
    }

    function clearView() {
        transactionView.__cleanUpFields()
        transactionView.modelIndex = -1
    }

    color: "white"
    width: 640
    height: 440

    ColumnLayout {
        id: mainLayoutColumn

        spacing: 20
        anchors {
            fill: parent
            margins: 10
        }

        RowLayout {
            id: textFieldsAndDateTimeRow
            spacing: 20
            width: parent.width

            ColumnLayout {
                id: textFieldsColumn
                spacing: 10

                LabeledTextField {
                    id: fromAccount
                    labelText: qsTr("From Account")
                    placeholderText: qsTr("Specify withdrawal account...")
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledTextField {
                    id: toAccount
                    labelText: qsTr("To Account")
                    placeholderText: qsTr("Specify deposit account...")
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: paymentAmount
                    labelText: qsTr("Payment Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: blockedAmount
                    labelText: qsTr("Blocked Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: actualAmount
                    labelText: qsTr("Actual Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }
            }

            ColumnLayout {
                id: dateTimeColumn
                spacing: 5

                Layout.alignment: Qt.AlignTop

                Text {
                    id: transactionDateLabel
                    text: qsTr("Transaction Date")
                }

                OldControls.Calendar {
                    id: transactionDateCalendar
                }
            }
        }


        ColumnLayout {
            id: descriptionColumn
            spacing: 5

            Layout.fillHeight: true

            Text {
                id: descriptionLabel
                text: qsTr("Description")
            }

            TextArea {
                id: transactionDescriptionTextArea
                Layout.preferredHeight: 55
                Layout.minimumHeight: 20
                Layout.fillWidth: true
                Layout.fillHeight: true
                placeholderText: "Transaction description..."
                background: Rectangle {
                    border.width: 1
                    border.color: "gray"
                }
            }
        }

        RowLayout {
            id: dialogButtonsRow
            spacing: 10
            width: parent.width

            Button {
                id: submitButton
                width: 100
                height: 30
                text: qsTr("Submit")
                onClicked: {
                    __submitTransaction()
                }
            }

            Button {
                id: cancelButton
                width: 100
                height: 30
                text: qsTr("Cancel")
                onClicked: {
                    __cancelTransaction()
                }
            }

            Item { Layout.fillWidth: true }
        }
    }

    function __submitTransaction() {
        var transaction = __getTransactionFromFields()
        __updateModelWithTransaction(transaction)
        submit(modelIndex, transaction)
    }

    function __cancelTransaction() {
        cancel()
    }

    function __updateModelWithTransaction(transaction) {
        if (modelIndex == -1) {
            transactionView.model.append(transaction)
        } else {
            transactionView.model.set(modelIndex, transaction)
        }
    }

    function __setFieldsUsingExistingTransaction(transaction) {
        transactionDateCalendar.selectedDate = Date.fromLocaleString(Qt.locale(), transaction.date, Locale.ShortFormat)

        fromAccount.text    = transaction.from_account
        toAccount.text      = transaction.to_account

        paymentAmount.amount    = transaction.payment_amount
        paymentAmount.currency  = transaction.payment_currency
        blockedAmount.amount    = transaction.blocked_amount
        blockedAmount.currency  = transaction.blocked_currency
        actualAmount.amount     = transaction.actual_amount
        actualAmount.currency   = transaction.actual_currency

        transactionDescriptionTextArea.text = transaction.description
    }

    function __cleanUpFields() {
        transactionDateCalendar.selectedDate = new Date()

        fromAccount.text        = ""
        toAccount.text          = ""

        paymentAmount.amount    = ""
        paymentAmount.currency  = ""
        blockedAmount.amount    = ""
        blockedAmount.currency  = ""
        actualAmount.amount     = ""
        actualAmount.currency   = ""

        transactionDescriptionTextArea.text = ""
    }

    function __getTransactionFromFields() {
        var transaction = {
            "date": transactionDateCalendar.selectedDate.toLocaleString(Locale.ShortFormat),

            "from_account":     fromAccount.text,
            "to_account":       toAccount.text,

            "payment_amount":   parseFloat(paymentAmount.amount),
            "payment_currency": paymentAmount.currency,
            "blocked_amount":   parseFloat(blockedAmount.amount),
            "blocked_currency": blockedAmount.currency,
            "actual_amount":    parseFloat(actualAmount.amount),
            "actual_currency":  actualAmount.currency,

            "description": transactionDescriptionTextArea.text
        }
        return transaction
    }
}
