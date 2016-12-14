import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

WorkspaceView {
    id: transactionView

    readonly property string viewType: "transactionView"
    fields: [fromAccount, toAccount, paymentAmount, blockedAmount, actualAmount, dateTimePicker, description]

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
                    roles: ["from_account"]
                    labelText: qsTr("From Account")
                    placeholderText: qsTr("Specify withdrawal account...")
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledTextField {
                    id: toAccount
                    roles: ["to_account"]
                    labelText: qsTr("To Account")
                    placeholderText: qsTr("Specify deposit account...")
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: paymentAmount
                    roles: ["payment_amount", "payment_currency"]
                    labelText: qsTr("Payment Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: blockedAmount
                    roles: ["blocked_amount", "blocked_currency"]
                    labelText: qsTr("Blocked Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }

                LabeledAmountCurrencyField {
                    id: actualAmount
                    roles: ["actual_amount", "actual_currency"]
                    labelText: qsTr("Actual Amount")
                    amountPlaceholderText: "0.00"
                    currencyPlaceholderText: "USD"
                    height: textFieldHeight
                    Layout.fillWidth: true
                }
            }

            LabeledDateTimePicker {
                id: dateTimePicker
                roles: ["date"]
                labelText: qsTr("Transaction Date")
                Layout.alignment: Qt.AlignTop
            }
        }

        LabeledTextArea {
            id: description
            roles: ["description"]
            Layout.preferredHeight: 55
            Layout.minimumHeight: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: qsTr("Transaction description...")
            labelText: qsTr("Description")
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
                    __submit()
                }
            }

            Button {
                id: cancelButton
                width: 100
                height: 30
                text: qsTr("Cancel")
                onClicked: {
                    __cancel()
                }
            }

            Item { Layout.fillWidth: true }
        }
    }
}
