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

            //Item { width: 10 }

            ToolButton {
                text: "Edit"
                onClicked: {
                    var row = transactionTable.currentRow
                    if (row > -1) {
                        var transaction = transactionListModel.get(row)
                        popup.openToEditExistingTransaction(transaction, row)
                    }
                }
            }

            //Item { width: 10 }

            ToolButton {
                text: "Delete"
            }

            Item { Layout.fillWidth: true }
        }
    }

    TransactionTable {
        id: transactionTable
        anchors.fill: parent
        model: transactionListModel

        onDoubleClicked: {
            var transaction = transactionListModel.get(row)
            popup.openToEditExistingTransaction(transaction, row)
        }
    }

    PopupView {
        id: popup

        x: root.width / 2 - width / 2
        y: root.height / 2 - height / 2

        onSubmitTransaction: {
            if (modelIndex === -1) {
                transactionListModel.addTransaction(transaction)
            }
            else {
                transactionListModel.updateTransaction(transaction, modelIndex)
            }
            popup.popStack()
        }

        onCancelTransaction: {
            popup.popStack()
        }

        onSubmitAccount: {

        }

        onCancelAccount: {
            popup.popStack()
        }
    }

    footer: TabBar {

    }

    ListModel {
        id: transactionListModel

        function updateTransaction(transaction, modelIndex) {
            transactionListModel.set(modelIndex, transaction)
        }

        function addTransaction(transaction) {
            transactionListModel.append(transaction)
        }

        Component.onCompleted: lazyDataLoader.sendMessage('load these damn items')
    }

    WorkerScript {
        id: lazyDataLoader
        source: "lazyLoader.js"

        onMessage: {
            var listModelItem = messageObject
            listModelItem.date = messageObject.date.toLocaleString(Locale.ShortFormat)
            transactionListModel.append(listModelItem)
            transactionTable.resizeColumnsToContents()
        }
    }
}
