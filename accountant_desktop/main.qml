import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtQml 2.2

ApplicationWindow {
    id: root
    visible: true
    width: 1000//Screen.desktopAvailableWidth
    height: 600//Screen.desktopAvailableHeight
    title: qsTr("The Accountant")

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "New"
                onClicked: {
                    popup.openToCreateNewTransaction()
                }
            }
            Item { Layout.fillWidth: true }
            ToolButton {
                text: "Edit"
                onClicked: {
                    var row = transactionTable.currentRow
                    if (row > -1) {
                        var transaction = transactionListMockModel.get(row)
                        popup.openToEditExistingTransaction(transaction, row)
                    }
                }
            }
            Item { Layout.fillWidth: true }
            ToolButton {
                text: "Delete"
            }
        }
    }

    TransactionTable {
        id: transactionTable
        anchors.fill: parent
        model: transactionListMockModel

        onDoubleClicked: {
            var transaction = transactionListMockModel.get(row)
            popup.openToEditExistingTransaction(transaction, row)
        }
    }

    Popup {
        id: popup
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape

        //width: transactionView.width
        //height: transactionView.height

        x: root.width / 2 - transactionView.width / 2
        y: root.height / 2 - transactionView.height / 2

        TransactionView {
            id: transactionView

            onSubmit: {
                if (modelIndex === -1) {
                    root.addTransactionToModel(transaction)
                }
                else {
                    root.updateTransactionInModel(transaction, modelIndex)
                }
                popup.close()
            }

            onCancel: {
                popup.close()
            }
        }

        function openToCreateNewTransaction() {
            transactionView.clearTransactionView()
            popup.open()
        }

        function openToEditExistingTransaction(transaction, modelIndex) {
            transactionView.setupTransactionView(transaction, modelIndex)
            popup.open()
        }
    }

    footer: TabBar {

    }

    ListModel {
        id: transactionListMockModel
        Component.onCompleted: lazyDataLoader.sendMessage('load these damn items')
    }

    WorkerScript {
        id: lazyDataLoader
        source: "lazyLoader.js"

        onMessage: {
            var listModelItem = messageObject
            listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
            transactionListMockModel.append(listModelItem)
        }
    }

    function updateTransactionInModel(transaction, modelIndex) {
        transactionListMockModel.set(modelIndex, transaction)
    }

    function addTransactionToModel(transaction) {
        transactionListMockModel.append(transaction)
    }
}
