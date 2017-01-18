import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

WorkspaceView {
    id: accountView

    readonly property string viewType: "accountView"
    fields: [accountName, accountDescription]

    ColumnLayout {
        id: mainLayoutColumn

        spacing: 20
        anchors {
            fill: parent
            margins: 10
        }

        LabeledTextField {
            id: accountName
            roles: ["name"]
            labelText: qsTr("Account Name")
            placeholderText: qsTr("Account name...")
            height: textFieldHeight
            Layout.fillWidth: true
        }

        LabeledTextField {
            id: accountCurrency
            roles: ["currency"]
            labelText: qsTr("Account Currency")
            placeholderText: qsTr("Account Currency...")
            height: textFieldHeight
            Layout.fillWidth: true
        }

        LabeledTextArea {
            id: accountDescription
            roles: ["description"]
            Layout.preferredHeight: 55
            Layout.minimumHeight: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: qsTr("Account description...")
            labelText: qsTr("Account Description")
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
