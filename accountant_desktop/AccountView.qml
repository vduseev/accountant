import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.2
import QtQuick.Layouts 1.1

Item {
    id: root

    property int textFieldHeight: 50

    signal submit(var account, var modelIndex)
    signal cancel()

    property int modelIndex: -1
    width: 640
    height: 240

    ColumnLayout {
        id: mainLayoutColumn

        spacing: 20

        anchors {
            fill: parent
            margins: 10
        }

        LabeledTextField {
            id: accountName
            labelText: qsTr("Account Name")
            placeholderText: qsTr("Enter account name...")
            height: textFieldHeight
            Layout.fillWidth: true
        }

        ColumnLayout {
            id: textFieldsColumn
            spacing: 5

            Text {
                id: descriptionLabel
                text: qsTr("Account Description")
            }

            TextArea {
                id: accountDescription
                Layout.preferredHeight: 55
                Layout.minimumHeight: 20
                Layout.fillWidth: true
                Layout.fillHeight: true
                placeholderText: "Enter acount description..."
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
                    var account = getFields()
                    submit(account, modelIndex)
                }
            }

            Button {
                id: cancelButton
                width: 100
                height: 30
                text: qsTr("Cancel")
                onClicked: {
                    cancel()
                }
            }

            Item { Layout.fillWidth: true }
        }
    }


    function setupView(account, modelIndex) {
        setFields(account)
        root.modelIndex = modelIndex
    }

    function clearView() {
        cleanUpFields()
        root.modelIndex = -1
    }

    function setFields(account) {
        accountName.text        = transaction.account_name
        accountDescription.text = transaction.account_description
    }

    function cleanUpFields() {
        accountName.text        = ""
        accountDescription.text = ""
    }

    function getFields() {
        var account = {
            "account_name":         accountName.text,
            "account_description":  accountDescription.text
        }
        return account
    }
}
